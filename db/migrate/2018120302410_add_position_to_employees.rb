class AddPositionToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :position, :integer
  end
end
