class AddColorToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :color, :string, default: '#000000'
    add_column :nodes, :label, :string
  end
end
