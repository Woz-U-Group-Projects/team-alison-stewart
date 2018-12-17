class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.string :to_emails,   null: false
      t.string :from_email,  null: false
      t.string :subject,     null: false
      t.string :body,        null: false

      t.timestamps
    end
  end
end
