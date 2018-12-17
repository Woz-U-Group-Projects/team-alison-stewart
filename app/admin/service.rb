ActiveAdmin.register Service do
  menu parent: 'Artona'

  permit_params :title, :preview_photo, :description, :position,
    :banner_photo, :contact_emails, :book_link, :order_link

  filter :title
  filter :employee_code

  config.sort_order = 'title'

  member_action :update_photos_position, method: :post do
    photos = params[:photos] || {}

    Photo.update(photos.keys, photos.values)
    render text: 'updated'
  end

  index do
    column 'Title' do |service|
      link_to service.title, admin_service_path(service)
    end
    column :position
    column :updated_at
  end

  show do |service|
    columns do
      column do
        attributes_table do
          row(:title)
          row 'Preview Photo' do |service|
            image_tag service.preview_photo
          end

          row 'Banner Photo' do |service|
            image_tag service.banner_photo
          end
          row 'Description' do |service|
            service.description&.html_safe
          end
          row(:book_link) { |s| status_tag(s.book_link) }
          row(:order_link) { |s| status_tag(s.order_link) }
          row(:position)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        render partial: 'admin/features/table', locals: { features: service.features }

        panel 'Photos' do
          render partial: 'admin/photos/table', locals: { photos: service.photos }
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :title
      f.input :preview_photo, as: :file
      f.input :banner_photo, as: :file
      f.input :description, as: :html_editor
      f.input :book_link, hint: 'Show the book button on the service page.'
      f.input :order_link, hint: 'Show the order button on the service page.'
      f.input :contact_emails, hint: 'A comma separated list of email addresses that wil be notified in service contact form. Leave blank to disable form.'
      f.input :position
    end

    f.actions
  end
end
