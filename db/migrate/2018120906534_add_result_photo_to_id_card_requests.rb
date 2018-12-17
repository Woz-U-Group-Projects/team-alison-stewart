class AddResultPhotoToIdCardRequests < ActiveRecord::Migration
  def change
    add_column :id_card_requests, :result_photo, :string
  end
end
