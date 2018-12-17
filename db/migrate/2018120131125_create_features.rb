class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string  :description, null: false
      t.integer :sitting_id,  null: false

      t.timestamps
    end
  end
end
