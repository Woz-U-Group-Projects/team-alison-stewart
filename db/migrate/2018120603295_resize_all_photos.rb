class ResizeAllPhotos < ActiveRecord::Migration
  def up
    Photo.all.each do |photo|
      photo.file_name.recreate_versions! if photo.file_name
    end
  end

  def down
  end
end
