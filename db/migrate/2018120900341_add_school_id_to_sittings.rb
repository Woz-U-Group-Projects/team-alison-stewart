class AddSchoolIdToSittings < ActiveRecord::Migration
  def change
    add_column :sittings, :school_id, :integer
  end
end
