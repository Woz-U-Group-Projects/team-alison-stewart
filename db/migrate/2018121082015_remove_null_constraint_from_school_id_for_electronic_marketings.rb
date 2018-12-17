class RemoveNullConstraintFromSchoolIdForElectronicMarketings < ActiveRecord::Migration
  def change
    change_column :electronic_marketings, :school_id, :integer, null: true
  end
end
