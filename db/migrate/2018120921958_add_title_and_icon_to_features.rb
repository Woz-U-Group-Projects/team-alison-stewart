class AddTitleAndIconToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :title, :string
    add_column :features, :icon,  :string
  end
end
