class CreateTimeTradeMetaData < ActiveRecord::Migration
  def change
    create_table :time_trade_meta_data do |t|
      t.string :campaign_id
      t.string :appointment_type_group_id
      t.string :company_name
      t.string :school_code,                null: false

      t.timestamps
    end

    add_index :time_trade_meta_data, :school_code, unique: true
  end
end
