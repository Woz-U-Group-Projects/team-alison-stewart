class MakeIdCardTemplatesUnique < ActiveRecord::Migration
  def change
    add_index :id_card_templates, :school_id, unique: true
  end
end
