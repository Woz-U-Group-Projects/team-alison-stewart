ActiveAdmin.register IdCardRequest do
  menu parent: 'Manage Schools'

  actions :all, except: [:new, :create]

  permit_params :attention_of, :attention_of_email

  action_item :render, only: :show do
    if resource.requested? || resource.errored? || resource.rendered?
      link_to 'Render', render_request_admin_id_card_request_path(resource), method: :post
    end
  end

  action_item :process, only: :show do
    if resource.rendered?
      link_to 'Mark as Processed', mark_as_processed_admin_id_card_request_path(resource), method: :patch
    end
  end

  member_action :render_request, method: :post do
    resource.state = 'requested'
    resource.save

    Resque.enqueue(IdCardGenerator, id_card_request_id: resource.id)

    flash[:notice] = 'ID Card Request will be rendered shortly'
    redirect_to admin_id_card_request_path(resource)
  end

  member_action :mark_as_processed, method: :patch do
    resource.process!

    flash[:notice] = 'ID Card Request has been marked as processed'
    redirect_to admin_id_card_request_path(resource)
  end

  member_action :edit, method: :get do
    redirect_to edit_id_card_request_path(resource.uuid)
  end

  filter :id
  filter :id_card_template
  filter :school, collection: proc { School.order(:name) }
  filter :attention_of
  filter :attention_of_email
  filter :state
  filter :created_at
  filter :updated_at
  filter :result_photo
  filter :result_pdf
  filter :student_name
  filter :student_number

  index do
    column (:id)
    column(:uuid) { |icr| link_to icr.uuid, admin_id_card_request_path(icr) }
    column :school
    column :student_name
    column :student_number
    column :attention_of
    column(:state) { |icr| status_tag icr.state }
    column "Comments" do |icr|
      icr.comments.map do |comment|
        if comment.text && !comment.custom_text.blank?
          "#{comment.text}, #{comment.custom_text}"
        else
          comment.text
        end
      end
    end
    column :created_at
    actions
  end

  show do |id_card_request|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:uuid)
          row 'State' do |id_card_request|
            status_tag id_card_request.state
          end
          row(:school)
          row(:student_name)
          row(:student_number)
          row(:attention_of)
          row(:attention_of_email)
          row 'Result Photo' do |id_card_request|
            image_tag id_card_request.result_photo
          end
          row 'Result PDF' do |id_card_request|
            link_to 'PDF File', id_card_request.result_pdf_url if id_card_request.result_pdf
          end
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Nodes' do
          render partial: 'admin/nodes/table', locals: { nodes: id_card_request.nodes, value: true }
        end
      end
    end

    panel 'Comments' do
      render partial: 'admin/comments/table', locals: { comments: id_card_request.comments }
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :attention_of
      f.input :attention_of_email
    end

    f.actions
  end
end
