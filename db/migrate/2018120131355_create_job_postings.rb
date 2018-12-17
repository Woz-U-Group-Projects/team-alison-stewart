class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.string    :name, null: false
      t.string    :title
      t.integer   :job_type_id
      t.text      :responsibilities
      t.text      :requirements
      t.datetime  :expiry_date

      t.timestamps
    end
  end
end
