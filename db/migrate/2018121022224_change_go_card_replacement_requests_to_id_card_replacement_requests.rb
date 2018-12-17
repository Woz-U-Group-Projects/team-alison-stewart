class ChangeGoCardReplacementRequestsToIdCardReplacementRequests < ActiveRecord::Migration
  def change
    rename_table :go_card_replacement_requests, :id_card_replacement_requests
  end
end
