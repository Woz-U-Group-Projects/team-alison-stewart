class ChangeSchoolIdIdCardTemplateIndex < ActiveRecord::Migration
  def change
    remove_index :id_card_templates, :school_id

    add_index :id_card_templates, :school_id
  end
end
