class ChangeLookBooksSerivceId < ActiveRecord::Migration
  def change
    change_column :look_books, :service_id, :integer, null: false
  end
end
