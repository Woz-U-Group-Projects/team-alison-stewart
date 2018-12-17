class AddJuniorFieldToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :junior_field, :string
  end
end
