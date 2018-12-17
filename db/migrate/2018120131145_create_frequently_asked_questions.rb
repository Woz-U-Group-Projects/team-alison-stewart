class CreateFrequentlyAskedQuestions < ActiveRecord::Migration
  def change
    create_table :frequently_asked_questions do |t|
      t.text :question,         null: false
      t.text :answer,           null: false
      t.string :question_type,  null: false

      t.timestamps
    end
  end
end
