class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string  :first_name,      null: false
      t.string  :middle_name,     null: false
      t.string  :last_name,       null: false
      t.string  :student_number,  null: false
      t.string  :email_address,   null: false
      t.string  :degree,          null: false
      t.integer :address_id
      t.string  :registration_type

      t.timestamps
    end
  end
end
