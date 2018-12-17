ActiveAdmin.register Feedback do
menu parent: 'Site'

permit_params :from_email, :subject, :body

filter :from_email, label: 'Customer Email'
filter :subject

actions :index, :show

index do
  column 'Customer Email', :from_email
  column :subject
  column :created_at
  actions
end

show do
  attributes_table do
    row :id
    row :from_email
    row :subject
    row :body
    row :updated_at
    row :created_at
  end
end
end
