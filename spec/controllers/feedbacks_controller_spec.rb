require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do

  describe '#new' do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "instantiates a new feedback instance variable" do
      get :new
      expect(assigns(:feedback)).to be_a_new(Feedback)
    end
  end

  describe '#create' do
    before(:each) do
      @params = {
        feedback: {
          from_email: 'test@test.com',
          subject: 'subject',
          body: 'body'
        }
      }
    end

    it 'should create a feedback' do
      expect{ post :create, @params }.to change{ Feedback.count }.by(1)
    end

    it 'should return 302' do
      post :create, @params

      expect(response.status).to eq(302)
    end

    it 'should return 302 when failed' do
      @params[:feedback][:from_email] = nil

      post :create, @params

      expect(response.status).to eq(200)
    end

    #   context "with valid attributes" do
    #   def valid_request
    #     post :create, feedback: {from_email: "test@test.com", subject: "subject", body: "this is a test message"}
    #   end
    #   it "saves a record to the database" do
    #     count_before = Feedback.count
    #     valid_request
    #     count_after = Feedback.count
    #     expect(count_after).to eq(count_before + 1)
    #   end
    #   it "redirects to the feedback thank you page" do
    #     valid_request
    #     expect(response).to redirect_to(thank_you_feedbacks_path)
    #   end
    #   it "sets a flash notice message" do
    #     valid_request
    #     expect(flash[:notice]).to be
    #   end
    # end
    #
    # context "with invalid attributes" do
    #   def invalid_request
    #     post :create, feedback: {from_email: "123"}
    #   end
    #   it "doesn't save a record on the database" do
    #     count_before = Feedback.count
    #     invalid_request
    #     count_after = Feedback.count
    #     expect(count_after).to eq(count_before)
    #   end
    # end
  end
end
