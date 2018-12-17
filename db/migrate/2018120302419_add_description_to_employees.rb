class AddDescriptionToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :description, :string
  end
end
