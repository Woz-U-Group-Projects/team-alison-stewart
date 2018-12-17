class ChangeLookBooksToBeService < ActiveRecord::Migration
  def change
    remove_column :look_books, :sitting_id
    remove_column :look_books, :school_id

    add_column :look_books, :service_id, :integer
    add_column :look_books, :title, :string
  end
end
