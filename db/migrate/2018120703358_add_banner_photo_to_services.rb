class AddBannerPhotoToServices < ActiveRecord::Migration
  def change
    add_column :services, :banner_photo, :string
  end
end
