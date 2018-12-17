ActiveAdmin.register LookBook do
  menu parent: 'Artona'

  permit_params :service_id, :title, :program_slug

  member_action :update_photos_position, method: :post do
    photos = params[:photos] || {}

    Photo.update(photos.keys, photos.values)
    render text: 'updated'
  end

  index do
    column 'ID' do |look_book|
      link_to look_book.id, admin_look_book_path(look_book)
    end
    column 'Title' do |look_book|
      link_to look_book.title, admin_look_book_path(look_book)
    end
    column 'Service' do |look_book|
      link_to look_book.service.title, admin_service_path(look_book.service) if look_book.service
    end
    column :program_slug
    actions
  end

  show do |look_book|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:title)
          row 'Service' do |look_book|
            link_to look_book.service.title, admin_service_path(look_book.service) if look_book.service
          end
          row(:program_slug)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Photos' do
          render partial: 'admin/photos/table', locals: { photos: look_book.photos }
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :title
      f.input :service_id, as: :select, collection: Service.all.map { |s| [s.title, s.id] }, include_blank: false
      f.input :program_slug, as: :select, collection: Program.all.map { |p| [p.name, p.slug] }
    end

    f.actions
  end

  controller do
    include ActiveAdmin::ViewsHelper
  end
end
