class CreateProgramNotes < ActiveRecord::Migration
  def change
    create_table :program_notes do |t|
      t.string  :program_slug
      t.integer :school_id,   null: false
      t.text    :text,        null: false

      t.timestamps
    end
  end
end
