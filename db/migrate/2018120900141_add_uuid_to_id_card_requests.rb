class AddUuidToIdCardRequests < ActiveRecord::Migration
  def change
    add_column :id_card_requests, :uuid, :string

    IdCardRequest.connection.schema_cache.clear!
    IdCardRequest.reset_column_information

    IdCardRequest.all.each do |icr|
      icr.uuid = SecureRandom.urlsafe_base64
      icr.save
    end

    change_column :id_card_requests, :uuid, :string, null: false
  end
end
