class ChangeGoCardRequestsToIdCardRequests < ActiveRecord::Migration
  def change
    rename_table :go_card_requests, :id_card_requests
  end
end
