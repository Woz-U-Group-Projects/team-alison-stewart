class AddPositionToServices < ActiveRecord::Migration
  def change
    add_column :services, :position, :integer
  end
end
