require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  subject{ @user }

  # Associations
  it { is_expected.to have_many(:comments) }
  it { is_expected.to belong_to(:school) }

  # Validations
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(6).is_at_most(100) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to validate_inclusion_of(:role).in_array(User::ROLES) }

  it 'should be invalid with invalid email' do
    @user.email = 'test'

    expect(@user.valid?).to eq(false)
  end

  it 'should be invalid when no password and no saved password' do
    @user.crypted_password = nil
    @user.password = nil

    expect(@user.valid?).to eq(false)
  end

  it 'should be invalid when no password confirmation and no saved password' do
    @user.crypted_password = nil
    @user.password_confirmation = nil

    expect(@user.valid?).to eq(false)
  end

  it 'should be invalid when too short password and no saved password' do
    @user.crypted_password = nil
    @user.password = 'aaa'
    @user.password_confirmation = 'aaa'

    expect(@user.valid?).to eq(false)
  end

  it 'should be invalid when too long password and no saved password' do
    @user.crypted_password = nil
    @user.password = 'a' * 41
    @user.password_confirmation = 'a' * 41

    expect(@user.valid?).to eq(false)
  end

  # Callbacks
  describe 'before_save' do
    it 'should encrypt the password' do
      @user = FactoryGirl.create(:user, password: 'password', password_confirmation: 'password')

      expect(@user.salt).not_to be_nil
      expect(@user.crypted_password).not_to be_nil
      expect(@user.crypted_password).not_to eq('password')
    end

    it 'should not encrypt the password if not present' do
      @user = FactoryGirl.create(:user, password: 'password', password_confirmation: 'password')
      before_value = @user.crypted_password

      @user.save

      expect(@user.crypted_password).to eq(before_value)
    end
  end

  # Class methods
  describe '#self.authenticate' do
    it 'should return user on success' do
      expect(User.authenticate(@user.email, 'password')).to eq(@user)
    end

    it 'should return nil on failure' do
      expect(User.authenticate(@user.email, 'wrong')).to be_nil
    end
  end

  describe '#self.encrypt' do
    it 'should return encrypted string' do
      expect(User.encrypt('password', 'salt')).not_to eq('password')
    end
  end

  # Instance methods
  describe '#encrypt' do
    it 'should return encrypted string' do
      expect(@user.encrypt('password')).not_to eq('password')
    end
  end

  describe '#authenticated?' do
    it 'should return true when password is correct' do
      expect(@user.authenticated?('password')).to eq(true)
    end

    it 'should return false when password is incorrect' do
      expect(@user.authenticated?('a')).to eq(false)
    end
  end

  describe '#remember_token?' do
    it 'should return true when token is set and current' do
      @user.remember_token_expires_at = Time.now + 2.days

      expect(@user.remember_token?).to eq(true)
    end

    it 'should return false when token is set and not current' do
      @user.remember_token_expires_at = 2.days.ago

      expect(@user.remember_token?).to eq(false)
    end
  end

  describe '#remember_me' do
    it 'should set remember token expiry to 2 weeks' do
      @user.remember_me

      expect(@user.remember_token_expires_at).to be > 13.days.from_now.utc
      expect(@user.remember_token_expires_at).to be < 15.days.from_now.utc
      expect(@user.remember_token).not_to be_nil
    end
  end

  describe '#remember_me_for' do
    it 'should set remember token expiry to given time' do
      @user.remember_me_for(3.weeks)

      expect(@user.remember_token_expires_at).to be > 20.days.from_now.utc
      expect(@user.remember_token_expires_at).to be < 22.days.from_now.utc
      expect(@user.remember_token).not_to be_nil
    end
  end

  describe '#remember_me_until' do
    it 'should set remember token expiry to given time from now' do
      @user.remember_me_until(2.weeks.from_now.utc)

      expect(@user.remember_token_expires_at).to be > 13.days.from_now.utc
      expect(@user.remember_token_expires_at).to be < 15.days.from_now.utc
      expect(@user.remember_token).not_to be_nil
    end
  end

  describe '#forget_me' do
    it 'should clear remember token fields' do
      @user.remember_me
      @user.forget_me

      expect(@user.remember_token_expires_at).to be_nil
      expect(@user.remember_token).to be_nil
    end
  end

  describe '#is?' do
    it 'should return true when is role' do
      @user.role = 'admin'

      expect(@user.is?(:admin)).to eq(true)
    end

    it 'should return flase when not role' do
      @user.role = 'csr'

      expect(@user.is?(:admin)).to eq(false)
    end
  end
end
