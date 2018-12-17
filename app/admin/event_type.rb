ActiveAdmin.register EventType do
  menu parent: 'Events And Dates'

  permit_params :highrise_field, :code, :program_slug, :name, :position

  filter :highrise_field
  filter :code

  config.sort_order = 'position'

  index do
    column 'Highrise Field' do |event_type|
      link_to event_type.highrise_field, admin_event_type_path(event_type)
    end
    column :name
    column :code
    column 'Program' do |event_type|
      Program.find(event_type.program_slug)&.name
    end
    column :position
  end

  show do |event_type|
    attributes_table do
      row(:id)
      row(:highrise_field)
      row(:name)
      row(:code)
      row 'Program' do |event_type|
        Program.find(event_type.program_slug)&.name
      end
      row(:position)
      row(:created_at)
      row(:updated_at)
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :highrise_field
      f.input :code
      f.input :program_slug, as: :select, collection: Program.all.map { |p| [p.name, p.slug] }
      f.input :position
    end

    f.actions
  end
end
