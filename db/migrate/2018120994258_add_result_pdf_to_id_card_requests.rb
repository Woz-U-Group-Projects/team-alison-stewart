class AddResultPdfToIdCardRequests < ActiveRecord::Migration
  def change
    add_column :id_card_requests, :result_pdf, :string
  end
end
