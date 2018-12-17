class CreateIdCardTemplates < ActiveRecord::Migration
  def change
    create_table :id_card_templates do |t|
      t.integer :school_id, null: false
      t.string  :base_photo

      t.timestamps
    end
  end
end
