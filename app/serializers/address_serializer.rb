class AddressSerializer < ActiveModel::Serializer
  attributes :address1,
             :address2,
             :address3,
             :city,
             :country,
             :created_at,
             :postal_code,
             :province,
             :updated_at

  belongs_to :owner
end
