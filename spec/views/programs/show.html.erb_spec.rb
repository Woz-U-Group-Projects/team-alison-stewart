require 'rails_helper'

describe 'programs/show.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @program = FactoryGirl.create(:program)
    @demo_videos = DemoVideo.all
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
