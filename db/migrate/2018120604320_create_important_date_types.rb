class CreateImportantDateTypes < ActiveRecord::Migration
  def change
    create_table :important_date_types do |t|
      t.string  :highrise_field,  null: false
      t.string  :code,            null: false
      t.string  :name
      t.boolean :dynamic_name
      t.integer :position

      t.timestamps
    end
  end
end
