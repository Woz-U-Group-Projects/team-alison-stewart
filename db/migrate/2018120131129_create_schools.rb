class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name,       null: false
      t.string :code,       null: false
      t.string :parent_code

      t.timestamps
    end

    add_index :schools, :code, unique: true
  end
end
