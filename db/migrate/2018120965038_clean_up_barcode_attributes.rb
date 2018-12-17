class CleanUpBarcodeAttributes < ActiveRecord::Migration
  def change
    change_column :id_card_templates, :school_id, :integer, null: true

    remove_column :nodes, :barcode_type

    add_column :nodes, :alignment, :string
  end
end
