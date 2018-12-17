ActiveAdmin.register FrequentlyAskedQuestion do
  menu parent: 'Site'

  permit_params :question, :answer, :frequently_asked_question_type_id, :position

  filter :frequently_asked_question_type, as: :select, collection: -> { FrequentlyAskedQuestionType.all.map { |qt| [qt.name, qt.id] } }

  index do
    column 'Question' do |frequently_asked_question|
      link_to frequently_asked_question.question, admin_frequently_asked_question_path(frequently_asked_question)
    end
    column 'Type' do |frequently_asked_question|
      link_to frequently_asked_question.frequently_asked_question_type.name, admin_frequently_asked_question_type_path(frequently_asked_question.frequently_asked_question_type) if frequently_asked_question.frequently_asked_question_type
    end
    column :position
    column :updated_at
  end

  show do |frequently_asked_question|
    attributes_table do
      row(:id)
      row(:question)
      row 'Answer' do |frequently_asked_question|
        frequently_asked_question.answer&.html_safe
      end
      row(:frequently_asked_question_type)
      row(:position)
      row(:created_at)
      row(:updated_at)
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :question
      f.input :answer, as: :html_editor
      f.input :frequently_asked_question_type_id, as: :select, collection: FrequentlyAskedQuestionType.all.order(:name).map { |qt| [qt.name, qt.id] }, include_blank: false
      f.input :position
    end

    f.actions
  end
end
