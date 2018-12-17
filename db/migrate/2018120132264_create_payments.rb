class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string  :uuid,                    null: false
      t.integer :amount,                  null: false
      t.string  :payment_method,          null: false
      t.date    :received_on,             null: false
      t.integer :gateway_transaction_id,  null: false
      t.integer :booking_id,              null: false

      t.timestamps
    end
  end
end
