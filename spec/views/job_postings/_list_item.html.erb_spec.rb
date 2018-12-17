require 'rails_helper'

describe 'job_postings/_list_item.html.erb' do
  before(:each) do
    @job_posting = FactoryGirl.create(:job_posting)
  end

  it 'should render' do
    expect{ render partial: 'job_postings/list_item', locals: { job_posting: @job_posting } }.not_to raise_error
  end
end
