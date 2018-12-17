class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :from_email
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
  end
end
