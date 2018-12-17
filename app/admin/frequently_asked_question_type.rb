ActiveAdmin.register FrequentlyAskedQuestionType do
  menu parent: 'Site'

  permit_params :name, :position

  filter :name

  config.sort_order = 'position'

  index do
    column 'Name' do |frequently_asked_question_type|
      link_to frequently_asked_question_type.name, admin_frequently_asked_question_type_path(frequently_asked_question_type)
    end
    column :position
    actions
  end

  show do |frequently_asked_question_type|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:name)
          row(:position)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Frequently Asked Questions' do
          table_for frequently_asked_question_type.frequently_asked_questions do
            column(:question) { |faq| link_to faq.question, admin_frequently_asked_question_path(faq) }
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :position
    end

    f.actions
  end
end
