class CreateSittings < ActiveRecord::Migration
  def change
    create_table :sittings do |t|
      t.string  :name,          null: false
      t.string  :duration,      null: false
      t.string  :sitting_fee
      t.string  :deposit
      t.integer :event_type_id, null: false
      t.integer :location_id,   null: false

      t.timestamps
    end
  end
end
