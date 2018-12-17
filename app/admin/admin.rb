ActiveAdmin.register User do
  menu parent: 'Site'

  permit_params :email, :password, :password_confirmation, :enabled,
    :role, :school_id

  filter :email

  index do
    column 'Email' do |user|
      link_to user.email, admin_user_path(user.id)
    end
    column 'Role' do |user|
      user.role.humanize
    end
    column 'School' do |user|
      link_to user.school&.name, admin_school_path(user.school) if user.school
    end
    column 'Enabled' do |user|
      boolean_to_english(user.enabled)
    end
  end

  show do |user|
    attributes_table do
      row :id
      row(:email)
      row 'role' do |user|
        user.role.humanize
      end

      if user.role == 'teacher'
        row(:school)
      end

      row(:enabled)
      row(:created_at)
      row(:updated_at)

    end
  end

  form partial: 'form'
end
