class AddGradGroupCodeToElectronicMarketings < ActiveRecord::Migration
  def change
    add_column :electronic_marketings, :grad_group_code, :string
  end
end
