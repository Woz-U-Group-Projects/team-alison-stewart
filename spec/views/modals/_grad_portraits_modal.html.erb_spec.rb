require 'rails_helper'

describe 'modals/_grad_portraits_modal.html.erb' do
  it 'should render' do
    expect{ render partial: 'modals/grad_portraits_modal', locals: { id: 'modal-1' } }.not_to raise_error
  end
end
