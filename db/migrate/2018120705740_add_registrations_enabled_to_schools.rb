class AddRegistrationsEnabledToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :registrations_enabled, :boolean, default: false
  end
end
