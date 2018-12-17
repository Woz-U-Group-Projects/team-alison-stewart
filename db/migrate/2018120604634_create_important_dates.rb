class CreateImportantDates < ActiveRecord::Migration
  def change
    create_table :important_dates do |t|
      t.integer :school_id,               null: false
      t.integer :important_date_type_id,  null: false
      t.string  :name,                    null: false
      t.string  :value,                   null: false

      t.timestamps
    end
  end
end
