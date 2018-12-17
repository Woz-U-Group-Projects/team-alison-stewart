class Nodes::Photo < Node
  # Attachments
  mount_uploader :node_photo, PhotoUploader
end
