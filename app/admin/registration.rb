ActiveAdmin.register Registration do
  menu parent: 'Manage Schools'

  actions :index, :show

  filter :school, collection: proc { School.order(:name) }
  filter :first_name
  filter :last_name
  filter :student_number
  filter :email_address
  filter :created_at

  index do
    column 'Name' do |registration|
      link_to registration.full_name, admin_registration_path(registration)
    end
    column(:student_number)
    column(:email_address)
    column 'School' do |registration|
      link_to registration.school.name, admin_school_path(registration.school.code)
    end
    actions
  end

  csv do
    column(:id)
    column(:first_name)
    column(:middle_name)
    column(:last_name)
    column(:student_number)
    column(:email_address)
    column(:school)
    column(:degree)
    column(:ceremony)
    column(:registration_type)
    column(:address1)     { |r| r.address&.address1 }
    column(:address2)     { |r| r.address&.address2 }
    column(:address3)     { |r| r.address&.address3 }
    column(:country)      { |r| r.address&.country }
    column(:province)     { |r| r.address&.province }
    column(:city)         { |r| r.address&.city }
    column(:postal_code)  { |r| r.address&.postal_code }
    column(:created_at)
    column(:updated_at)
  end

  show do |registration|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:first_name)
          row(:middle_name)
          row(:last_name)
          row(:student_number)
          row(:email_address)
          row(:school)
          row(:degree)
          row(:ceremony)
          row(:registration_type)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Address' do
          attributes_table_for registration.address do
            row(:id)
            row(:address1)
            row(:address2)
            row(:address3)
            row(:country)
            row(:province)
            row(:city)
            row(:postal_code)
          end
        end
      end
    end
  end
end
