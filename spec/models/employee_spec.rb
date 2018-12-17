require 'rails_helper'

RSpec.describe Employee, type: :model do
  before do
    @employee = FactoryGirl.create(:employee)
  end

  subject{ @employee }

  # Instance methods
  describe '#full_name' do
    it 'should return first and last name' do
      expect(@employee.full_name).to eq("#{@employee.first_name} #{@employee.last_name}")
    end
  end
end
