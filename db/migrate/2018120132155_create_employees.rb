class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :title,            null: false
      t.string :employee_code
      t.string :telephone_number
      t.string :extension
      t.string :cellphone_number
      t.string :email_address

      t.timestamps
    end
  end
end
