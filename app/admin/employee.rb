ActiveAdmin.register Employee do
  menu parent: 'Artona'

  permit_params :title, :employee_code, :email_address, :telephone_number,
    :cellphone_number, :extension, :first_name, :last_name,
    :position, :description

  filter :title
  filter :employee_code

  config.sort_order = 'title'

  index do
    column 'Name' do |employee|
      link_to employee.full_name, admin_employee_path(employee)
    end
    column :title
    column :employee_code
    column :email_address
  end

  show do |employee|
    attributes_table do
      row(:first_name)
      row(:last_name)
      row(:title)
      row(:employee_code)
      row(:description)
      row(:email_address)
      row(:telephone_number)
      row(:extension)
      row(:cellphone_number)
      row(:created_at)
      row(:updated_at)
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :title
      f.input :employee_code
      f.input :description
      f.input :email_address
      f.input :telephone_number
      f.input :extension
      f.input :cellphone_number
      f.input :position
    end

    f.actions
  end
end
