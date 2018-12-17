class PhraseSerializer < ActiveModel::Serializer
  attributes :name,
             :prefix,
             :suffix,
             :text

  belongs_to :node
end
