class RenameNodeTypeToType < ActiveRecord::Migration
  def change
    rename_column :nodes, :node_type, :type
  end
end
