require 'rails_helper'

describe IdCardRequestsController, type: :controller do
  render_views

  before(:each) do
    @school = FactoryGirl.create(:school)
    @user = FactoryGirl.create(:user, role: 'teacher', school: @school)

    Setting.show_replace_id_card = '1'

    sign_in_as(@user)
  end

  describe '#index' do
    it 'should return 200' do
      get :index

      expect(response.status).to eq(200)
    end

    it 'should return 200 if not authenticated' do
      sign_out

      get :index

      expect(response.status).to eq(200)
    end

    it 'should render the index template' do
      get :index

      expect(response).to render_template('index')
    end

    it 'should not redirect if setting turned off but admin' do
      @user = FactoryGirl.create(:user, role: 'admin')
      sign_in_as(@user)

      Setting.show_replace_id_card = false

      get :index

      expect(response.status).to eq(200)
    end
  end

  describe '#find' do
    it 'should return 200' do
      get :find

      expect(response.status).to eq(200)
    end

    it 'should render the find template' do
      get :find

      expect(response).to render_template('find')
    end

    it 'should redirect if setting turned off' do
      Setting.show_replace_id_card = false

      get :find

      expect(response).to redirect_to(root_path)
    end

    it 'should not redirect if setting turned off but admin' do
      @user = FactoryGirl.create(:user, role: 'admin')
      sign_in_as(@user)

      Setting.show_replace_id_card = false

      get :find

      expect(response.status).to eq(200)
    end
  end

  describe '#new' do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @id_card_template = FactoryGirl.create(:id_card_template, school: @school)

      subject = {
        subjects: [
          {
            first_name: 'Test',
            last_name: 'McTest',
            photo_url: 'http://google.ca'
          }
        ]
      }.to_json

      allow(controller).to receive_message_chain(:open, :read).and_return(subject)

      @params = {
        id_card_request: {
          id_card_template_id: @id_card_template.id,
          student_number: '123ABC'
        }
      }
    end

    it 'should return 200' do
      get :new, @params

      expect(response.status).to eq(200)
    end

    it 'should render the new template' do
      get :new, @params

      expect(response).to render_template('new')
    end

    it 'should 404 when ID card template cannot be found' do
      @params[:id_card_request][:id_card_template_id] = 'wrong'

      get :new, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when ID card template does not have school' do
      @school.destroy

      get :new, @params

      expect(response.status).to eq(404)
    end

    it 'should generate a new ID card request' do
      get :new, @params

      expect(controller.instance_variable_get(:@id_card_request)).to be_a(IdCardRequest)
    end

    it 'should generate text nodes with phrases' do
      @text_node = FactoryGirl.create(:text_node, owner: @id_card_template)

      get :new, @params

      expect(controller.instance_variable_get(:@id_card_request).nodes.first).to be_a(Nodes::Text)
      expect(controller.instance_variable_get(:@id_card_request).nodes.first.phrases.first).to be_a(Phrase)
    end

    it 'should generate photo nodes' do
      @text_node = FactoryGirl.create(:photo_node, junior_field: 'photo_url', owner: @id_card_template)

      get :new, @params

      expect(controller.instance_variable_get(:@id_card_request).nodes.first).to be_a(Nodes::Photo)
      expect(controller.instance_variable_get(:@id_card_request).nodes.first.remote_node_photo_url).to eq('http://google.ca')
    end

    it 'should redirect if setting turned off' do
      Setting.show_replace_id_card = false

      get :new, @params

      expect(response).to redirect_to(root_path)
    end

    it 'should not redirect if setting turned off but admin' do
      @user = FactoryGirl.create(:user, role: 'admin')
      sign_in_as(@user)

      Setting.show_replace_id_card = false

      get :new, @params

      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @id_card_template = FactoryGirl.create(:id_card_template, school: @school)

      @params = {
        id_card_request: {
          id_card_template_id: @id_card_template.id,
          school_id: @school.id,
          attention_of: 'Test McTest',
          attention_of_email: 'test@test.com',
          student_name: 'Test',
          nodes_attributes: {
            '0' => {
              type: 'Nodes::Text',
              name: 'First Name',
              x: 0,
              y: 0,
              width: 100,
              height: 50,
              font_family: 'Helvetica',
              point_size: 16,
              junior_field: 'first_name',
              phrases_attributes: {
                '0' => {
                  name: 'First Name',
                  text: 'Test',
                  junior_field: 'first_name'
                }
              }
            }
          },
          comments_attributes: {
            '0' => {
              user_id: @user.id,
              text: 'Test comment'
            }
          }
        }
      }
    end

    it 'should create a new ID card request' do
      expect{ post :create, @params }.to change{ IdCardRequest.count }.by(1)
    end

    it 'should create a new node' do
      expect{ post :create, @params }.to change{ Node.count }.by(1)
    end

    it 'should create a new phrase' do
      expect{ post :create, @params }.to change{ Phrase.count }.by(1)
    end

    it 'should create a new comment' do
      expect{ post :create, @params }.to change{ Comment.count }.by(1)
    end

    it 'should redirect to thank you page' do
      post :create, @params

      expect(response).to redirect_to(thank_you_id_card_request_path(IdCardRequest.last.uuid))
    end

    it 'should 422 with bad request' do
      @params[:id_card_request][:attention_of] = nil

      post :create, @params

      expect(response.status).to eq(422)
    end

    it 'should render the new template with bad request' do
      @params[:id_card_request][:attention_of] = nil

      post :create, @params

      expect(response).to render_template('new')
    end

    it 'should 404 when ID card template cannot be found' do
      @params[:id_card_request][:id_card_template_id] = 'wrong'

      post :create, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when ID card template does not have school' do
      @school.destroy

      post :create, @params

      expect(response.status).to eq(404)
    end

    it 'should not create a new comment' do
      @params[:id_card_request][:comments_attributes]['0'][:text] = ''

      expect{ post :create, @params }.to_not change{ Comment.count }
    end

    it 'should redirect if setting turned off' do
      Setting.show_replace_id_card = false

      post :create, @params

      expect(response).to redirect_to(root_path)
    end

    it 'should not redirect if setting turned off but admin' do
      @user = FactoryGirl.create(:user, role: 'admin')
      sign_in_as(@user)

      Setting.show_replace_id_card = false

      post :create, @params

      expect(response).to redirect_to(thank_you_id_card_request_path(IdCardRequest.last.uuid))
    end
  end

  describe '#edit' do
    before(:each) do
      @school = FactoryGirl.create(:school)
      @id_card_request = FactoryGirl.create(:id_card_request, school: @school)

      @params = { id: @id_card_request.uuid }
    end

    it 'should return 200' do
      get :edit, @params

      expect(response.status).to eq(200)
    end

    it 'should render the edit template' do
      get :edit, @params

      expect(response).to render_template('edit')
    end

    it 'should 404 when ID card request cannot be found' do
      @params[:id] = 'wrong'

      get :edit, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#update' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @school = FactoryGirl.create(:school)
      @id_card_template = FactoryGirl.create(:id_card_template, school: @school)
      @id_card_request = FactoryGirl.create(:id_card_request, school: @school, id_card_template: @id_card_template)
      @node = FactoryGirl.create(:text_node, owner: @id_card_request)

      @params = {
        id: @id_card_request.uuid,
        id_card_request: {
          id_card_template_id: @id_card_template.id,
          school_id: @school.id,
          attention_of: 'Test McTest',
          attention_of_email: 'test@test.com',
          nodes_attributes: {
            '0' => {
              id: @node.id,
              name: 'First Name',
              phrases_attributes: {
                '0' => {
                  id: @node.phrases.first.id,
                  name: 'First Name'
                }
              }
            }
          }
        }
      }
    end

    it 'should update the ID card request' do
      patch :update, @params

      expect(@id_card_request.reload.attention_of).to eq('Test McTest')
    end

    it 'should update the nodes' do
      patch :update, @params

      expect(@node.reload.name).to eq('First Name')
    end

    it 'should update the phrases' do
      patch :update, @params

      expect(@node.reload.phrases.first.name).to eq('First Name')
    end

    it 'should redirect to show page' do
      patch :update, @params

      expect(response).to redirect_to(id_card_request_path(@id_card_request.uuid))
    end

    it 'should 422 with bad request' do
      @params[:id_card_request][:attention_of] = nil

      patch :update, @params

      expect(response.status).to eq(422)
    end

    it 'should render the edit template with bad request' do
      @params[:id_card_request][:attention_of] = nil

      patch :update, @params

      expect(response).to render_template('edit')
    end

    it 'should 404 when ID card request cannot be found' do
      @params[:id] = 'wrong'

      patch :update, @params

      expect(response.status).to eq(404)
    end

    it 'should 404 when ID card render_template cannot be found' do
      @params[:id_card_request][:id_card_template_id] = 'wrong'

      patch :update, @params

      expect(response.status).to eq(404)
    end
  end

  describe '#show' do
    before(:each) do
      @id_card_request = FactoryGirl.create(:id_card_request)

      @params = { id: @id_card_request.uuid }
    end

    it 'should render the show template' do
      get :show, @params

      expect(response).to render_template('show')
    end

    it 'should 404 when ID card request does not exist' do
      get :show, id: 'wrong'

      expect(response.status).to eq(404)
    end
  end

  describe '#thank_you' do
    before(:each) do
      @id_card_request = FactoryGirl.create(:id_card_request)

      @params = { id: @id_card_request.uuid }
    end

    it 'should render the thank you template' do
      get :thank_you, @params

      expect(response).to render_template('thank_you')
    end

    it 'should 404 when ID card request does not exist' do
      get :thank_you, id: 'wrong'

      expect(response.status).to eq(404)
    end
  end
end
