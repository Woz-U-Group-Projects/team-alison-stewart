ActiveAdmin.register Event do
  menu parent: 'Events And Dates'

  permit_params :date, :school_id, :event_type_id

  filter :school, collection: proc { School.order(:name) }
  filter :event_type, collection: proc { EventType.order(:name) }
  filter :date
  filter :created_at
  filter :updated_at

  index do
    id_column
    column 'Date' do |event|
      link_to event.date, admin_event_path(event)
    end
    column :school
    column 'Event Type' do |event|
      link_to event.event_type.highrise_field, admin_event_type_path(event.event_type) if event.event_type
    end
  end

  show do |event|
    attributes_table do
      row(:id)
      row(:name)
      row(:school)
      row 'Event Type' do
        link_to event.event_type.highrise_field, admin_event_type_path(event.event_type) if event.event_type
      end
      row(:date)
      row(:created_at)
      row(:updated_at)
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :date
      f.input :school_id, as: :select, input_html: { class: 'select2' }, collection: School.all.order(:name).map { |s| [s.name, s.id] }
      f.input :event_type_id, as: :select, collection: EventType.all.map { |et| [et.highrise_field, et.id] }
    end

    f.actions
  end
end
