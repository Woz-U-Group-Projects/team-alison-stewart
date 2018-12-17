class AddConvocationIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :convocation_id, :integer
    add_column :registrations, :school_id, :integer, null: false

    add_index :registrations, :convocation_id
    add_index :registrations, :school_id
  end
end
