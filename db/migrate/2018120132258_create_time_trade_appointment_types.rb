class CreateTimeTradeAppointmentTypes < ActiveRecord::Migration
  def change
    create_table :time_trade_appointment_types do |t|
      t.integer :time_trade_meta_data_id
      t.string  :type_id,                 null: false
      t.string  :photo_type
      t.string  :resource_id,             null: false

      t.timestamps
    end

    # Have to provide a custom name because the generated one is too long
    add_index :time_trade_appointment_types, [:time_trade_meta_data_id, :photo_type], unique: true, name: 'index_appointment_types_on_meta_data_and_photo_type'
  end
end
