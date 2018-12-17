class AddNameToIdCardTemplates < ActiveRecord::Migration
  def change
    add_column :id_card_templates, :name, :string

    IdCardTemplate.connection.schema_cache.clear!
    IdCardTemplate.reset_column_information

    IdCardTemplate.all.each_with_index do |ict, index|
      ict.name = index
      ict.save
    end

    change_column :id_card_templates, :name, :string, null: false
  end
end
