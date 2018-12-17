class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string  :title,         null: false
      t.string  :preview_photo
      t.text    :description

      t.timestamps
    end
  end
end
