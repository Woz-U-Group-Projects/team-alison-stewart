class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :name,        null: false
      t.text      :description
      t.string    :date
      t.integer   :school_id,   null: false

      t.timestamps
    end

    add_index :events, [:name, :school_id], unique: true
  end
end
