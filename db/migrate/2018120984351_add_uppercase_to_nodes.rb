class AddUppercaseToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :uppercase, :boolean, default: false
  end
end
