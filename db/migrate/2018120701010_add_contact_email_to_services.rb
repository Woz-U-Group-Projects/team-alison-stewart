class AddContactEmailToServices < ActiveRecord::Migration
  def change
    add_column :services, :contact_emails, :string
  end
end
