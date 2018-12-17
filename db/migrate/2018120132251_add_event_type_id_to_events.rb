class AddEventTypeIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_type_id, :integer, null: false
    remove_column :events, :description
  end
end
