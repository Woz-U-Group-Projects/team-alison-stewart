class NodeSerializer < ActiveModel::Serializer
  attributes :alignment,
             :color,
             :crop_height,
             :crop_width,
             :crop_x,
             :crop_y,
             :font_family,
             :height,
             :remote_mask_url,
             :mask_url,
             :name,
             :point_size,
             :remote_node_photo_url,
             :type,
             :uppercase,
             :width,
             :x,
             :y

  belongs_to :owner
  has_many :phrases
end
