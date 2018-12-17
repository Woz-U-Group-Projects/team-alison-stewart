class PopulateFaqTypes < ActiveRecord::Migration
  QUESTION_TYPES = %w{
    billing
    booking
    delivery
    educator
    miscellaneous
    ordering
    parent
    popular
    preparing
    student
    troubleshooting
    yearbooks
  }

  def up
    QUESTION_TYPES.each do |faq_type|
      FrequentlyAskedQuestionType.create!(name: faq_type)
    end
  end

  def down
    FrequentlyAskedQuestionType.all.destroy_all
  end
end
