class AddGraduationYearToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :graduation_year, :string
  end
end
