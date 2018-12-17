ActiveAdmin.register Product do
  menu parent: 'Artona'

  permit_params :name, :description, :preview_photo,
    :video_url, :platform, :position

  filter :name

  config.sort_order = 'position'

  index do
    column 'Name', sortable: :name do |product|
      link_to product.name, admin_product_path(product.id)
    end
    column :description
    column :position
    column :updated_at
  end

  show do |product|
    attributes_table do
      row :id
      row(:name)
      row(:description)
      row(:position)
      row 'Preview Photo' do |product|
        image_tag product.preview_photo
      end
      row(:video_url)
      row(:platform)
      row(:created_at)
      row(:updated_at)
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :description
      f.input :position
      f.input :preview_photo, as: :file
      f.input :video_url
      f.input :platform, as: :select, collection: Product::PLATFORMS.map { |p| [p, p] }
    end

    f.actions
  end

  controller do
    include ActiveAdmin::ViewsHelper
  end
end
