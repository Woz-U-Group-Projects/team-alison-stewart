class IdCardRequestSerializer < ActiveModel::Serializer
  attributes :attention_of,
             :attention_of_email,
             :created_at,
             :id,
             :result_pdf_url,
             :result_photo_url,
             :state,
             :student_number,
             :updated_at

  belongs_to  :school
  has_many    :nodes
  has_one     :id_card_template
end
