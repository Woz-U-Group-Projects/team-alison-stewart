FactoryGirl.define do
  factory :photo_node, parent: :node, class: 'Nodes::Photo' do
    name 'Photo'
    type 'Nodes::Photo'
    node_photo File.open(Rails.root.join('spec', 'fixtures', 'images', 'buildings.jpg'))
  end
end
