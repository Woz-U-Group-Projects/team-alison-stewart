FactoryGirl.define do
  factory :text_node, parent: :node, class: 'Nodes::Text' do
    sequence(:name) { |n| "Field-#{n}" }
    type 'Nodes::Text'
    font_family 'Helvetica'
    point_size 12
    color '#000000'

    after(:create) do |node|
      FactoryGirl.create(:phrase, node: node)
    end
  end
end
