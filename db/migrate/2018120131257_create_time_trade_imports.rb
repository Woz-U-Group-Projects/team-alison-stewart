class CreateTimeTradeImports < ActiveRecord::Migration
  def change
    create_table :time_trade_imports do |t|
      t.string  :file,      null: false
      t.text    :import_log

      t.timestamps
    end
  end
end
