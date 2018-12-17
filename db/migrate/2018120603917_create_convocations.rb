class CreateConvocations < ActiveRecord::Migration
  def change
    create_table :convocations do |t|
      t.datetime  :ceremony,  null: false
      t.integer   :school_id, null: false

      t.timestamps
    end
  end
end
