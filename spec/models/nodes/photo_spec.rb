require 'rails_helper'

RSpec.describe Nodes::Text, type: :model do
  before do
    @photo_node = FactoryGirl.create(:photo_node)
  end

  subject{ @photo_node }
end
