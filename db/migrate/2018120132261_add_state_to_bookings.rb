class AddStateToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :state, :string, default: 'pending', null: false
  end
end
