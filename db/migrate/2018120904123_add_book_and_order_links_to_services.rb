class AddBookAndOrderLinksToServices < ActiveRecord::Migration
  def change
    add_column :services, :book_link,   :boolean, default: false
    add_column :services, :order_link,  :boolean, default: false
  end
end
