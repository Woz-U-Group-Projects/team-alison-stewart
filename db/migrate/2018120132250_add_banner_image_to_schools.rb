class AddBannerImageToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :banner_photo, :string
  end
end
