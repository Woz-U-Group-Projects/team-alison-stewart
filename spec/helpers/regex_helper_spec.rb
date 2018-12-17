require 'rails_helper'

describe RegexHelper, type: :helper do
  describe 'POSTAL_CODE' do
    it 'should match test cases' do
      tests = ['V9A 4P7', 'V9A4P7']

      tests.each do |test|
        should_match(RegexHelper::POSTAL_CODE, test)
      end
    end

    it 'should not match test cases' do
      tests = ['123', 'abc']

      tests.each do |test|
        should_not_match(RegexHelper::POSTAL_CODE, test)
      end
    end
  end

  describe 'ZIP_CODE' do
    it 'should match test cases' do
      tests = ['12345']

      tests.each do |test|
        should_match(RegexHelper::ZIP_CODE, test)
      end
    end

    it 'should not match test cases' do
      tests = ['V9A 4P7', 'V9A4P7']

      tests.each do |test|
        should_not_match(RegexHelper::ZIP_CODE, test)
      end
    end
  end

  describe 'DYNAMIC_NAME' do
    it 'should match test cases' do
      tests = ['Test: 123', 'Test : 123']

      tests.each do |test|
        should_match(RegexHelper::DYNAMIC_NAME, test)
      end
    end

    it 'should not match test cases' do
      tests = ['123', 'Test']

      tests.each do |test|
        should_not_match(RegexHelper::DYNAMIC_NAME, test)
      end
    end
  end

  describe 'EMAIL' do
    it 'should match test cases' do
      tests = ['test@test.com']

      tests.each do |test|
        should_match(RegexHelper::EMAIL, test)
      end
    end

    it 'should not match test cases' do
      tests = ['test@test']

      tests.each do |test|
        should_not_match(RegexHelper::EMAIL, test)
      end
    end
  end

  describe 'NUMBER' do
    it 'should match test cases' do
      tests = ['123', '1.2']

      tests.each do |test|
        should_match(RegexHelper::NUMBER, test)
      end
    end

    it 'should not match test cases' do
      tests = ['blah', '1abc2']

      tests.each do |test|
        should_not_match(RegexHelper::NUMBER, test)
      end
    end
  end

  describe 'PHONE_NUMBER' do
    it 'should match test cases' do
      tests = ['1235551234', '123-555-1234']

      tests.each do |test|
        should_match(RegexHelper::PHONE_NUMBER, test)
      end
    end

    it 'should not match test cases' do
      tests = ['blah', '1abc2']

      tests.each do |test|
        should_not_match(RegexHelper::PHONE_NUMBER, test)
      end
    end
  end

  describe 'IMAGE_FILE' do
    it 'should match test cases' do
      tests = ['image.jpg', 'image.jpeg', 'image.gif', 'image.png']

      tests.each do |test|
        should_match(RegexHelper::IMAGE_FILE, test)
      end
    end

    it 'should not match test cases' do
      tests = ['image.csv', 'image.txt']

      tests.each do |test|
        should_not_match(RegexHelper::IMAGE_FILE, test)
      end
    end
  end

  def should_match(regex, test)
    expect(regex.match(test)).to be_truthy
  end

  def should_not_match(regex, test)
    expect(regex.match(test)).to be_falsey
  end
end
