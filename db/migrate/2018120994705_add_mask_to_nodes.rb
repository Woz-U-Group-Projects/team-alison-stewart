class AddMaskToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :mask, :string
  end
end
