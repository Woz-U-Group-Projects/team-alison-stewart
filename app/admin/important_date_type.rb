ActiveAdmin.register ImportantDateType do
  menu parent: 'Events And Dates'

  permit_params :highrise_field, :code, :dynamic_name, :name, :position

  filter :highrise_field
  filter :code

  config.sort_order = 'position'

  index do
    column 'Highrise Field' do |important_date_type|
      link_to important_date_type.highrise_field, admin_important_date_type_path(important_date_type)
    end
    column 'Name' do |important_date_type|
      link_to important_date_type.name, admin_important_date_type_path(important_date_type)
    end
    column :code
    column :dynamic_name
    column :position
  end

  show do |important_date_type|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:highrise_field)
          row(:code)
          row(:name)
          row(:dynamic_name)
          row(:position)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Programs' do
          table_for important_date_type.important_date_type_programs do |important_date_type_program|
            column(:program_slug) do |important_date_type_program|
              Program.find(important_date_type_program.program_slug).name
            end
            column(:actions) do |important_date_type_program|
              link_to 'Delete', admin_important_date_type_important_date_type_program_path(important_date_type.id, important_date_type_program.id), method: :delete, data: { confirm: 'Are you sure?' }
            end
          end

          div do
            link_to 'Add program', new_admin_important_date_type_important_date_type_program_path(important_date_type.id)
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :highrise_field
      f.input :code
      f.input :name
      f.input :dynamic_name
      f.input :position
    end

    f.actions
  end
end
