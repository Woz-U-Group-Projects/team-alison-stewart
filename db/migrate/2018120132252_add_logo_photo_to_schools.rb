class AddLogoPhotoToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :logo_photo, :string
  end
end
