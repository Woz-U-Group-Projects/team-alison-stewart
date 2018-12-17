require 'rails_helper'

RSpec.describe UserDefinedField, type: :model do
  before do
    @user_defined_field = FactoryGirl.create(:user_defined_field)
  end

  subject{ @user_defined_field }

  # Associations
  it { is_expected.to belong_to(:customer) }

  # Class methods
  describe '#self.customer_ids_for_student_number' do
    it 'should find customer ids by student number' do
      @customer = FactoryGirl.create(:customer)

      @user_defined_field.ID = UserDefinedField::FIELD_MAPPINGS[:student_number][:name]
      @user_defined_field.STRING_VAL = '123456'
      @user_defined_field.DOCUMENT_ID = @customer.id
      @user_defined_field.save

      expect(UserDefinedField.customer_ids_for_student_number('123456')).to eq([@customer.id])
    end
  end
end
