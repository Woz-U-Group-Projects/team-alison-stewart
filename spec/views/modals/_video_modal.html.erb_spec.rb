require 'rails_helper'

describe 'modals/_video_modal.html.erb' do
  it 'should render' do
    expect{ render partial: 'modals/video_modal' }.not_to raise_error
  end
end
