class CreateGatewayTransactions < ActiveRecord::Migration
  def change
    create_table :gateway_transactions do |t|
      t.integer :amount
      t.string  :action
      t.boolean :success
      t.string  :reference
      t.text    :message
      t.text    :response

      t.timestamps
    end
  end
end
