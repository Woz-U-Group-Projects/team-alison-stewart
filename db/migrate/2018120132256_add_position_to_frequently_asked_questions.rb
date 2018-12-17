class AddPositionToFrequentlyAskedQuestions < ActiveRecord::Migration
  def change
    add_column :frequently_asked_questions, :position, :integer
  end
end
