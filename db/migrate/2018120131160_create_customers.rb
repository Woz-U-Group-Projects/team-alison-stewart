class CreateCustomers < ActiveRecord::Migration
  def change
    create_table 'CUSTOMER', { id: false } do |t|
      t.string :ID, primary: true

      t.string :ADDR_1
      t.string :ADDR_2
      t.string :ADDR_3
      t.string :CITY
      t.string :STATE
      t.string :ZIPCODE
      t.string :COUNTRY
      t.string :CONTACT_FIRST_NAME
      t.string :CONTACT_LAST_NAME
      t.string :CONTACT_PHONE
      t.string :CONTACT_FAX
      t.string :CONTACT_MOBILE
      t.string :CONTACT_EMAIL
      t.string :NAME
      t.string :DISCOUNT_CODE
      t.string :FREE_ON_BOARD
    end
  end
end
