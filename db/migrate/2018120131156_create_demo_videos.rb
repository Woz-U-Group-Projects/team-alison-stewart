class CreateDemoVideos < ActiveRecord::Migration
  def change
    create_table :demo_videos do |t|
      t.string :title,          null: false
      t.string :description,    null: false
      t.string :video_url,      null: false
      t.string :still_screen
      t.integer :event_type_id, null: false
      t.integer :location_id,   null: false

      t.timestamps
    end

    add_index :demo_videos, [:event_type_id, :location_id], unique: true
  end
end
