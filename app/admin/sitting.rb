ActiveAdmin.register Sitting do
  menu parent: 'Site'

  permit_params :name, :duration, :sitting_fee, :deposit,
    :event_type_id, :grad_program_code, :grad_group_code, :school_id,
    :sitting_type

  filter :name

  config.sort_order = 'name'

  member_action :update_features_position, method: :post do
    features = params[:features] || {}

    Feature.update(features.keys, features.values)
    render text: 'updated'
  end

  index do
    column 'Name' do |sitting|
      link_to sitting.name, admin_sitting_path(sitting)
    end
    column :event_type
    column :grad_program_code
    column :grad_group_code
    column :sitting_type
    column :school
  end

  show do |sitting|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:name)
          row(:duration)
          row(:sitting_fee)
          row(:deposit)
          row 'Event Type' do
            link_to sitting.event_type.highrise_field, admin_event_type_path(sitting.event_type) if sitting.event_type
          end
          row(:grad_program_code)
          row(:grad_group_code)
          row(:sitting_type)
          row(:school)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        render partial: 'admin/features/table', locals: { features: sitting.features }
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Details' do
      f.input :name
      f.input :duration
      f.input :sitting_fee
      f.input :deposit
      f.input :event_type_id, as: :select, collection: EventType.all.map { |et| [et.highrise_field, et.id] }
      f.input :grad_program_code, hint: 'This should match the grad program code being used in Highrise.'
      f.input :grad_group_code, hint: 'This should match the grad group code being used in Highrise.'
      f.input :school_id, label: 'School', input_html: { class: 'select2' }, as: :select, collection: School.all.map { |s| [s.name, s.id] }
      f.input :sitting_type, as: :select, collection: Sitting::SITTING_TYPES, include_blank: false
    end

    f.actions
  end
end
