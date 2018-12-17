require 'rails_helper'

describe IdCardGenerator do
  let(:worker) { IdCardGenerator }

  describe '#perform' do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @id_card_template = FactoryGirl.create(:id_card_template, school: @school)
      @id_card_request = FactoryGirl.create(:id_card_request, state: 'requested', school: @school)

      @text_node1 = FactoryGirl.create(:text_node, owner: @id_card_request, x: 100, y: 100, width: 100, height: 50, alignment: 'center', uppercase: true)
      @text_node2 = FactoryGirl.create(:text_node, owner: @id_card_request, x: 100, y: 160, width: 100, height: 50)

      @photo_node = FactoryGirl.create(:photo_node, owner: @id_card_request, x: 200, y: 0, height: 100, width: 100)

      @params = { 'id_card_request_id' => @id_card_request.id }
    end

    it 'should render request' do
      worker.perform(@params)

      expect(@id_card_request.reload.result_photo_url).not_to be_nil
    end

    it 'should mark the request as rendered' do
      worker.perform(@params)

      expect(@id_card_request.reload.rendered?).to eq(true)
    end

    it 'should send failure email if cannot be rendered' do
      @text_node1.color = '123'
      @text_node1.save

      expect{ worker.perform(@params) }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
