class SchoolSerializer < ActiveModel::Serializer
  attributes :code,
             :created_at,
             :id,
             :name,
             :updated_at

  has_many  :id_card_templates
  has_one   :address
end
