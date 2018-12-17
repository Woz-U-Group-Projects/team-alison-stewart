ActiveAdmin.register ImportantDate do
  menu parent: 'Events And Dates'

  permit_params :name, :school_id, :important_date_type_id,
   :value

  filter :school, collection: proc { School.order(:name) }
  filter :important_date_type, collection: proc { ImportantDateType.order(:name) }
  filter :name
  filter :value
  filter :created_at
  filter :updated_at

  index do
    id_column
    column 'Name' do |important_date|
      link_to important_date.name, admin_important_date_path(important_date)
    end
    column :value
    column :school
    column 'Important Date Type' do |important_date|
      link_to important_date.important_date_type.highrise_field, admin_event_type_path(important_date.important_date_type) if important_date.important_date_type
    end
  end

  show do |important_date|
    attributes_table do
      row(:id)
      row(:name)
      row(:value)
      row(:school)
      row 'Event Type' do
        link_to important_date.important_date_type.highrise_field, admin_important_date_type_path(important_date.important_date_type) if important_date.important_date_type
      end
      row(:created_at)
      row(:updated_at)
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :value
      f.input :school_id, as: :select, input_html: { class: 'select2' }, collection: School.all.map { |s| [s.name, s.id] }
      f.input :important_date_type_id, as: :select, collection: ImportantDateType.all.map { |idt| [idt.highrise_field, idt.id] }
    end

    f.actions
  end
end
