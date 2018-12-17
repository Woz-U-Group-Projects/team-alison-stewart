class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name,         null: false
      t.string :description,  null: false
      t.string :platform,     null: false

      t.timestamps
    end
  end
end
