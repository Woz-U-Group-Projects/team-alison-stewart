class CreateFrequentlyAskedQuestionTypes < ActiveRecord::Migration
  def change
    create_table :frequently_asked_question_types do |t|
      t.string  :name,    null: false
      t.integer :position

      t.timestamps
    end
  end
end
