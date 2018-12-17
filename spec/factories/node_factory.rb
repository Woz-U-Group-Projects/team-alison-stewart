FactoryGirl.define do
  factory :node do
    owner factory: :id_card_template

    type 'Nodes::Text'
    sequence(:name) { |n| "node-#{n}" }
    x 0
    y 0
    width 100
    height 50
    font_family 'Helvetica'
    point_size 12
  end
end
