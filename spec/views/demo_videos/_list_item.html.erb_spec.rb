require 'rails_helper'

describe 'demo_videos/_list_item.html.erb' do
  before(:each) do
    @demo_video = FactoryGirl.create(:demo_video)
  end

  it 'should render' do
    expect{ render partial: 'demo_videos/list_item', locals: { demo_video: @demo_video, index: 1 } }.not_to raise_error
  end
end
