class AddIdCardTemplateIdToIdCardRequests < ActiveRecord::Migration
  def up
    add_column :id_card_requests, :id_card_template_id, :integer

    IdCardRequest.connection.schema_cache.clear!
    IdCardRequest.reset_column_information

    IdCardRequest.all.each do |icr|
      icr.id_card_template_id = icr.school.id_card_templates.first&.id
      icr.save!
    end

    change_column :id_card_requests, :id_card_template_id, :integer, null: false
  end

  def down
    remove_column :go_card_requests, :go_card_template_id
  end
end
