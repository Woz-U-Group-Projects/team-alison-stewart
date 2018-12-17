class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string  :file_name
      t.integer :owner_id
      t.string  :owner_type
      t.string  :description
      t.integer :position

      t.timestamps
    end
  end
end
