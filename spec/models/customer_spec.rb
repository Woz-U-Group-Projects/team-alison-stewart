require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    @customer = FactoryGirl.create(:customer)
  end

  subject{ @customer }

  # Associations
  it { is_expected.to have_many(:user_defined_fields) }

  # Class methods
  describe '#self.find_by_student_number' do
    it 'should find by student number' do
      @user_defined_field = FactoryGirl.create(:user_defined_field, ID: UserDefinedField::FIELD_MAPPINGS[:student_number][:name], STRING_VAL: '123456', DOCUMENT_ID: @customer.id)

      expect(Customer.find_by_student_number('123456')).to eq([@customer])
    end
  end

  describe '#self.find_by_school_code_and_graduation_year' do
    it 'should find by school code for grad customer' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save

      expect(Customer.find_by_school_code_and_graduation_year('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GRAD)).to eq([@customer])
    end

    it 'should find by school code for group customer' do
      @customer.id = "TEST#{Utils.photography_year}-123G"
      @customer.save

      expect(Customer.find_by_school_code_and_graduation_year('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GROUP)).to eq([@customer])
    end
  end

  describe '#self.find_by_student_number_and_graduation_year_and_school_code_and_sitting_type' do
    it 'should find based on parameters' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save

      @user_defined_field = FactoryGirl.create(:user_defined_field, ID: UserDefinedField::FIELD_MAPPINGS[:student_number][:name], STRING_VAL: '123456', DOCUMENT_ID: @customer.id)

      expect(Customer.find_by_student_number_and_graduation_year_and_school_code_and_sitting_type('123456', Utils.photography_year, 'TEST', Sitting::SITTING_TYPE_GRAD)).to eq([@customer])
    end
  end

  describe '#self.find_by_id' do
    it 'should find by id' do
      expect(Customer.find_by_id(@customer.id)).to eq(@customer)
    end
  end

  describe '#self.find_by_name' do
    it 'should find customer by contact first and last name' do
      @customer.first_name = 'First'
      @customer.last_name = 'Last'
      @customer.save

      expect(Customer.find_by_name('First Last')).to eq([@customer])
    end
  end

  describe '#self.reserve_new' do
    it 'should reserve a record in the DB if one is present' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save

      customer = Customer.reserve_new('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GRAD)

      expect(customer).to be_a(Customer)
      expect(customer.name).to eq(Customer::RESERVED_NAME)
    end

    it 'should return nil if no record is reservable' do
      @customer.id = "BLAH#{Utils.photography_year}-123"
      @customer.save

      expect(Customer.reserve_new('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GRAD)).to be_nil
    end

    context 'should check if the paired customer is also available' do
      before do
        @customer.destroy
        @customer1 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-123")
        @customer2 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-124")
        @customer3 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-125")
        @customer4 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-123G")
        @customer5 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-124G")
        @customer6 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-125G")
      end

      it 'should return correct customer when there is no paired customer for grad' do
        @customer1.name = 'Test McTest'
        @customer1.save

        @customer2.name = 'Test McTest2'
        @customer2.save

        @customer4.destroy
        @customer5.destroy
        @customer6.destroy

        customer = Customer.reserve_new('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GRAD)

        expect(customer).to be_a(Customer)
        expect(customer).to eq(@customer3)
      end

      it 'should return correct customer when there is no paired customer for group' do
        @customer4.name = 'Test McTest'
        @customer4.save

        @customer5.name = 'Test McTest2'
        @customer5.save

        @customer1.destroy
        @customer2.destroy
        @customer3.destroy

        customer = Customer.reserve_new('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GROUP)

        expect(customer).to be_a(Customer)
        expect(customer).to eq(@customer6)
      end

      it 'should check if the group paired customer is available when given a grad customer' do
        @customer4.name = 'Test McTest'
        @customer4.save

        @customer5.name = 'Test McTest2'
        @customer5.save

        customer = Customer.reserve_new('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GRAD)

        expect(customer).to be_a(Customer)
        expect(customer).to eq(@customer3)
      end

      it 'should check if the group paired customer is available when given a group customer' do
        @customer1.name = 'Test McTest'
        @customer1.save

        @customer2.name = 'Test McTest2'
        @customer2.save


        customer = Customer.reserve_new('TEST', Utils.photography_year, Sitting::SITTING_TYPE_GROUP)


        expect(customer).to be_a(Customer)
        expect(customer).to eq(@customer6)
      end
    end
  end

  describe '#self.reserve_paired_customer' do
    it 'should reserve a group record when a grad customer id is given' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save
      @customer2 = FactoryGirl.create(:customer, id: @customer.id + 'G')

      customer = Customer.reserve_paired_customer(@customer)

      expect(@customer2.reload.name).to eq(Customer::RESERVED_NAME)
    end

    it 'should do nothing if group record is already populated' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save
      @customer2 = FactoryGirl.create(:customer, id: @customer.id + 'G', name: 'Test McTest')

      customer = Customer.reserve_paired_customer(@customer)

      expect(@customer2.reload.name).to_not eq(Customer::RESERVED_NAME)
    end

    it 'should do nothing if group record does not exist' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save

      customer = Customer.reserve_paired_customer(@customer)
    end

    it 'should reserve a grad record when a group customer id is given' do
      @customer.id = "TEST#{Utils.photography_year}-123G"
      @customer.save
      @customer2 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-123")

      customer = Customer.reserve_paired_customer(@customer)

      expect(@customer2.reload.name).to eq(Customer::RESERVED_NAME)
    end

    it 'should reserve a group record when a grad customer id is given' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save

      @customer2 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-123G")

      customer = Customer.reserve_paired_customer(@customer)

      expect(@customer2.reload.name).to eq(Customer::RESERVED_NAME)
    end
  end

  # Dynamic methods
  describe 'dynamic methods' do
    it 'should have methods defined for user defined fields' do
      UserDefinedField::FIELD_MAPPINGS.keys.each do |field_name|
        expect(@customer).to respond_to(field_name)
      end
    end
  end

  # Instance methods
  describe '#school' do
    it 'should return the school when present' do
      @school = FactoryGirl.create(:school, code: 'TEST')
      @customer.id = 'TEST16-123'

      expect(@customer.school).to eq(@school)
    end

    it 'should return nil when school not present' do
      @customer.id = 'TEST16-123'

      expect(@customer.school).to eq(@school)
    end
  end

  describe '#paired_customer' do
    it 'should find paired group customer' do
      @customer.id = "TEST#{Utils.photography_year}-123"
      @customer.save
      @customer2 = FactoryGirl.create(:customer, id: @customer.id + 'G')

      expect(@customer.paired_customer).to eq(@customer2)
    end

    it 'should find paired grad customer' do
      @customer.id = "TEST#{Utils.photography_year}-123G"
      @customer.save
      @customer2 = FactoryGirl.create(:customer, id: "TEST#{Utils.photography_year}-123")

      expect(@customer.paired_customer).to eq(@customer2)
    end
  end
end
