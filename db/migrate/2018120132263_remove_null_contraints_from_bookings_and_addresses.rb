class RemoveNullContraintsFromBookingsAndAddresses < ActiveRecord::Migration
  def change
    change_column :addresses, :address1,    :string, null: true
    change_column :addresses, :city,        :string, null: true
    change_column :addresses, :province,    :string, null: true
    change_column :addresses, :country,     :string, null: true
    change_column :addresses, :postal_code, :string, null: true

    change_column :bookings, :customer_id,    :string,  null: true
    change_column :bookings, :first_name,     :string,  null: true
    change_column :bookings, :last_name,      :string,  null: true
    change_column :bookings, :email_student,  :string,  null: true
    change_column :bookings, :phone_student,  :string,  null: true
    change_column :bookings, :phone_parent,   :string,  null: true
    change_column :bookings, :height_ft,      :integer, null: true
    change_column :bookings, :height_in,      :integer, null: true
    change_column :bookings, :gender,         :string,  null: true
    change_column :bookings, :address_id,     :integer, null: true
  end
end
