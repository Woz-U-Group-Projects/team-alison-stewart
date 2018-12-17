class CreateIdCardRequests < ActiveRecord::Migration
  def change
    create_table :id_card_requests do |t|
      t.integer :school_id,           null: false
      t.string  :attention_of,        null: false
      t.string  :attention_of_email,  null: false

      t.string :state,                null: false, default: 'pending'

      t.timestamps
    end
  end
end
