require 'rails_helper'

describe 'id_card_requests/new.html.erb' do
  before(:each) do
    @school = FactoryGirl.create(:school)
    @id_card_template = FactoryGirl.create(:id_card_template, school: @school)
    @id_card_request = IdCardRequest.new

    @id_card_request.id_card_template = @id_card_template
    @id_card_request.school = @school
    @id_card_request.student_number = '123ABC'

    # Generate all the nodes
    @id_card_template.nodes.order(:position).each do |node|
      new_node = node.dup

      @id_card_request.nodes << new_node
    end
  end

  it 'should render' do
    expect{ render }.not_to raise_error
  end
end
