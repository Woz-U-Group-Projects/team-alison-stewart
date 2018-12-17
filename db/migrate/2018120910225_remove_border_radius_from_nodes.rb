class RemoveBorderRadiusFromNodes < ActiveRecord::Migration
  def change
    remove_column :nodes, :border_radius
  end
end
