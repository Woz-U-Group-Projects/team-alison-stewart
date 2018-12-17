class ChangeGoCardTemplateIdToIdCardTemplateId < ActiveRecord::Migration
  def change
    rename_column :id_card_requests, :go_card_template_id, :id_card_template_id
  end
end
