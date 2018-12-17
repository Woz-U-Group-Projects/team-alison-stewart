class AddPositionToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :position, :integer
  end
end
