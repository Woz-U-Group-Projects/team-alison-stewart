class AddImageToIdCardReplacementRequests < ActiveRecord::Migration
  def change
    add_column :id_card_replacement_requests, :image, :string
  end
end
