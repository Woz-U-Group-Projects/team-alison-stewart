class AddFrequentlyAskedQuestionTypeIdToFrequentlyAskedQuestions < ActiveRecord::Migration
  def change
    add_column :frequently_asked_questions, :frequently_asked_question_type_id, :integer

    FrequentlyAskedQuestion.connection.schema_cache.clear!
    FrequentlyAskedQuestion.reset_column_information

    FrequentlyAskedQuestion.all.each do |faq|
      faq.frequently_asked_question_type_id = FrequentlyAskedQuestionType.where(name: faq.question_type).first&.id
      faq.save
    end

    remove_column :frequently_asked_questions, :question_type
  end
end
