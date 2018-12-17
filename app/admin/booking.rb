ActiveAdmin.register Booking do
  menu parent: 'Manage Bookings'

  actions :index, :show

  filter :customer_id
  filter :first_name
  filter :last_name

  Booking::STATES.each do |state|
    scope state.to_sym
  end

  index do
    column(:customer_id) { |b| link_to b.customer_id, admin_booking_path(b) }
    column :first_name
    column :last_name
    column :sitting_type
    column(:state) { |b| status_tag b.state }
    actions
  end

  csv do
    column :id
    column :customer_id
    column :first_name
    column :last_name
    column :email_student
    column :email_parent
    column :phone_student
    column :phone_parent
    column :student_number
    column :height_ft
    column :height_in
    column :gender
    column :sitting_type
    column :faculty_school_code
    column :uploaded
    column :uploaded_at
    column :created_at
    column :updated_at
    column :state
  end

  show do
    columns do
      column do
        attributes_table do
          row(:customer_id) do
            booking.customer_id
          end
          row :state
          row(:payment) do
            link_to booking.payment.uuid, admin_payment_path(booking.payment) if booking.payment
          end
          row :first_name
          row :last_name
          row :email_student
          row :email_parent
          row :phone_student
          row :phone_parent
          row :student_number
          row :height_ft
          row :height_in
          row :gender
          row :sitting_type
          row :faculty_school_code
          row :uploaded
          row :uploaded_at
          row :created_at
          row :updated_at
        end
      end

      column do
        panel 'Address' do
          attributes_table_for booking.address do
            row :address1
            row :address2
            row :address3
            row :city
            row :province
            row :country
            row :postal_code
          end
        end
      end
    end
  end
end
