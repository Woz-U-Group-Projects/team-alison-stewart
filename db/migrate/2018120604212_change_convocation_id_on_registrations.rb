class ChangeConvocationIdOnRegistrations < ActiveRecord::Migration
  def change
    remove_column :registrations, :convocation_id

    Convocation.connection.schema_cache.clear!
    Convocation.reset_column_information

    add_column :registrations, :ceremony, :datetime
  end
end
