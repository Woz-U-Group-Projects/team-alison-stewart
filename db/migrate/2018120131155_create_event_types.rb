class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string  :highrise_field,  null: false
      t.string  :code,            null: false
      t.integer :program_id,      null: false

      t.timestamps
    end
  end
end
