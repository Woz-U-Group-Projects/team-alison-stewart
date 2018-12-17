class ChangeGoCardTemplatesToIdCardTemplates < ActiveRecord::Migration
  def change
    rename_table :go_card_templates, :id_card_templates
  end
end
