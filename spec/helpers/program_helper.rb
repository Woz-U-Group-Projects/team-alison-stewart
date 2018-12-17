require 'rails_helper'

describe ProgramHelper, type: :helper do
  describe '#program_icon' do
    it 'should return string' do
      expect(program_icon(Program::GRADUATION_SLUG)).to be_a(String)
    end
  end
end
