class AddExtraFieldsToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :suffix,         :string
    add_column :nodes, :border_radius,  :integer
    add_column :nodes, :barcode_type,   :string

    rename_column :nodes, :label, :prefix
  end
end
