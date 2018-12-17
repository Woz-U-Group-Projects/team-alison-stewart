class AddGradGroupCodeToSittings < ActiveRecord::Migration
  def change
    add_column :sittings, :grad_group_code, :string
  end
end
