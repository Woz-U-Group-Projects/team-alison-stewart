class RemoveNameFromEvents < ActiveRecord::Migration
  def change
    remove_index :events, [:name, :school_id]
    remove_column :events, :name

    add_index :events, :school_id
    add_index :events, :event_type_id
    add_index :events, [:school_id, :event_type_id], unique: true
  end
end
