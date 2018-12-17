require 'rails_helper'
require 'cancan/matchers'

describe Ability, type: :model do
  describe 'User' do
    describe 'abilities' do
      subject(:ability) { Ability.new(user) }

      context 'when is a guest' do
        let(:user) { nil }

        it { is_expected.to be_able_to(:read, :all) }

        it { is_expected.not_to be_able_to(:manage, :all) }
      end

      context 'when is an admin' do
        let(:user) { FactoryGirl.create(:user) }

        it { is_expected.to be_able_to(:manage, :all) }
      end

      context 'when is a teacher' do
        let(:user) { FactoryGirl.create(:user, role: 'teacher') }

        it { is_expected.to be_able_to(:create, :id_card_request) }
        it { is_expected.to be_able_to(:create, :node) }
      end
    end
  end
end
