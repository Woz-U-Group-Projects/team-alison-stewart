ActiveAdmin.register ContactRequest do
  menu parent: 'Artona'

  actions :index, :show

  filter :from_email
  filter :subject

  index do
    column :to_emails
    column :from_email
    column :subject
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :to_emails
      row :from_emails
      row :subject
      row :body
      row :updated_at
      row :created_at
    end
  end
end
