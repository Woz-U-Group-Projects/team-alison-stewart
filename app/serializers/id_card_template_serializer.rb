class IdCardTemplateSerializer < ActiveModel::Serializer
  attributes :base_photo_url,
             :created_at,
             :id,
             :updated_at

  belongs_to  :school
  has_many    :nodes
end
