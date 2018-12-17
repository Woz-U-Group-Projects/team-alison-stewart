class AddCustomTextToComments < ActiveRecord::Migration
  def change
    add_column :comments, :custom_text, :string
  end
end
