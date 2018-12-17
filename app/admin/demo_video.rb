ActiveAdmin.register DemoVideo do
  menu parent: 'Site'

  permit_params :title, :description, :video_url, :still_screen,
    :event_type_id, :grad_program_code, :grad_group_code

  filter :title
  filter :description

  member_action :update_features_position, method: :post do
    features = params[:features] || {}

    Feature.update(features.keys, features.values)
    render text: 'updated'
  end

  index do
    column 'Title' do |demo_video|
      link_to demo_video.title, admin_demo_video_path(demo_video)
    end
    column :event_type
    column :grad_program_code
    column :grad_group_code
  end

  show do |demo_video|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:title)
          row(:description)
          row(:video_url)
          row 'Still Screen' do |demo_video|
            image_tag demo_video.still_screen
          end
          row(:event_type)
          row(:grad_program_code)
          row(:grad_group_code)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        render partial: 'admin/features/table', locals: { features: demo_video.features }
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :title
      f.input :description
      f.input :video_url
      f.input :still_screen, as: :file
      f.input :event_type_id, as: :select, collection: EventType.all.map { |et| [et.name, et.id] }
      f.input :grad_program_code, hint: 'This should match the grad program code being used in Highrise.'
      f.input :grad_group_code, hint: 'This should match the grad group code being used in Highrise.'
    end

    f.actions
  end
end
