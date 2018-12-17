class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string   :address1,     null: false
      t.string   :address2
      t.string   :address3
      t.string   :city,         null: false
      t.string   :province,     null: false
      t.string   :country,      null: false
      t.string   :postal_code,  null: false

      t.timestamps
    end
  end
end
