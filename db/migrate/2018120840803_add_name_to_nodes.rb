class AddNameToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :name, :string
  end
end
