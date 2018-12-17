class AddSittingTypeToSittings < ActiveRecord::Migration
  def change
    add_column :sittings, :sitting_type, :string, default: 'grad', null: false
  end
end
