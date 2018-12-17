class CreateLookBooks < ActiveRecord::Migration
  def change
    create_table :look_books do |t|
      t.integer :sitting_id, null: false
      t.integer :school_id

      t.timestamps
    end
  end
end
