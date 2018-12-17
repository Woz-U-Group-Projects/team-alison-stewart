class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string  :node_type,   null: false
      t.integer :owner_id,    null: false
      t.string  :owner_type,  null: false
      t.integer :x,           null: false
      t.integer :y,           null: false
      t.integer :width,       null: false
      t.integer :height,      null: false

      # Text nodes
      t.string  :text
      t.string  :font_family
      t.integer :point_size

      # Photo nodes
      t.string  :node_photo
      t.integer :crop_x
      t.integer :crop_y
      t.integer :crop_width
      t.integer :crop_height

      t.timestamps
    end
  end
end
