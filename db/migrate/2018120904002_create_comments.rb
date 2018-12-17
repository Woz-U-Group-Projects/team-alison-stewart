class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id,     null: false
      t.integer :owner_id,    null: false
      t.string  :owner_type,  null: false
      t.string  :text,        null: false

      t.timestamps
    end
  end
end
