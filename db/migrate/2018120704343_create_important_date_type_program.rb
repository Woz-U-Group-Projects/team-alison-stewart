class CreateImportantDateTypeProgram < ActiveRecord::Migration
  def change
    create_table :important_date_type_programs do |t|
      t.integer :important_date_type_id, null: false
      t.string  :program_slug, null: false

      t.timestamps
    end
  end
end
