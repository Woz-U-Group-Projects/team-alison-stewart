class AddPositionToJobTypes < ActiveRecord::Migration
  def change
    add_column :job_types, :position, :integer
  end
end
