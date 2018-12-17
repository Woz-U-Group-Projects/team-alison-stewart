class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string    :customer_id,             null: false
      t.string    :first_name,              null: false
      t.string    :last_name,               null: false
      t.string    :email_student,           null: false
      t.string    :email_parent
      t.string    :phone_student,           null: false
      t.string    :phone_parent,            null: false
      t.string    :student_number
      t.integer   :height_ft,               null: false
      t.integer   :height_in,               null: false
      t.string    :gender,                  null: false
      t.string    :sitting_type
      t.string    :faculty_school_code
      t.boolean   :uploaded
      t.datetime  :uploaded_at

      t.timestamps
    end
  end
end
