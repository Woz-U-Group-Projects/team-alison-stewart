class AddVideoUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :video_url,     :string
    add_column :products, :preview_photo, :string
  end
end
