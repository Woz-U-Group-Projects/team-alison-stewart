class CreateElectronicMarketings < ActiveRecord::Migration
  def change
    create_table :electronic_marketings do |t|
      t.integer :school_id,     null: false
      t.string  :program_slug,  null: false
      t.string  :name,          null: false
      t.string  :file,          null: false
      t.integer :position

      t.timestamps
    end
  end
end
