class AddPositionToJobPostings < ActiveRecord::Migration
  def change
    add_column :job_postings, :position, :integer
  end
end
