ActiveAdmin.register School do
  menu parent: 'Manage Schools'

  permit_params :name, :code, :parent_code, :logo_photo,
    :grad_program_code, :grad_group_code, :school_day_program_code, :registrations_enabled

  filter :name
  filter :code

  config.sort_order = 'name'

  member_action :update_photos_position, method: :post do
    photos = params[:photos] || {}

    Photo.update(photos.keys, photos.values)
    render text: 'updated'
  end

  index do
    column 'Name', sortable: :name do |school|
      link_to school.name, admin_school_path(school.code)
    end
    column 'School Code' do |school|
      link_to school.code, admin_school_path(school.code)
    end
    column :updated_at
  end

  show do |school|
    columns do
      column do
        attributes_table do
          row :id
          row(:name)
          row(:code)
          row 'Parent School Code' do |school|
            link_to school.parent_code, admin_school_path(school.parent_code) unless school.parent_code.blank?
          end
          row(:grad_program_code)
          row(:grad_group_code)
          row(:school_day_program_code)
          row 'Logo Photo' do |school|
            image_tag school.logo_photo
          end
          row(:registrations_enabled) { |s| status_tag s.registrations_enabled }
          row(:created_at)
          row(:updated_at)
        end

        render partial: 'admin/addresses/panel', locals: { address: school.address }

        panel 'Electronic Marketing' do
          table_for school.electronic_marketings do
            column(:name) { |em| link_to em.name, admin_electronic_marketing_path(em) }
            column(:program_slug)
            column(:position)
          end
        end
      end

      column do
        panel 'Events' do
          table_for school.events do
            column(:date) { |e| link_to e.date, admin_event_path(e) }
            column(:event_type) { |e| e.event_type.highrise_field }
          end
        end

        panel 'Important Dates' do
          table_for school.important_dates do
            column(:name) { |imp_date| link_to imp_date.name, admin_important_date_path(imp_date) }
            column(:value)
            column(:important_date_type) { |imp_date| imp_date.important_date_type.highrise_field }
          end
        end

        # Show convocations if school is university
        panel 'Program Notes' do
          table_for school.program_notes do |program_note|
            column(:text)
            column(:program) do |program_note|
              Program.find(program_note.program_slug).name unless program_note.program_slug.blank?
            end
            column(:actions) do |program_note|
              edit    = link_to 'Edit', edit_admin_school_program_note_path(school.code, program_note.id)
              delete  = link_to 'Delete', admin_school_program_note_path(school.code, program_note.id), method: :delete, data: { confirm: 'Are you sure?' }

              safe_join [edit, delete], ' '
            end
          end

          div do
            link_to 'Create program note', new_admin_school_program_note_path(school.code)
          end
        end

        # Show convocations if school is university
        panel 'Convocations' do
          table_for school.convocations do |convocation|
            column(:ceremony)
            column(:actions) do |convocation|
              edit    = link_to 'Edit', edit_admin_school_convocation_path(school.code, convocation.id)
              delete  = link_to 'Delete', admin_school_convocation_path(school.code, convocation.id), method: :delete, data: { confirm: 'Are you sure?' }

              safe_join [edit, delete], ' '
            end
          end

          div do
            link_to 'Create convocation', new_admin_school_convocation_path(school.code)
          end
        end

        panel 'Photos' do
          render partial: 'admin/photos/table', locals: { photos: school.photos }
        end
      end
    end

    columns do
      column do
        panel 'Time Trade' do
          table_for school.time_trade_meta_datas.map(&:appointment_types).flatten do
            column 'Campaign ID' do |appointment_type|
              appointment_type&.time_trade_meta_data&.campaign_id
            end
            column 'Appointment Type Group ID' do |appointment_type|
              appointment_type&.time_trade_meta_data&.appointment_type_group_id
            end
            column 'Company Name' do |appointment_type|
              appointment_type&.time_trade_meta_data&.company_name
            end
            column :photo_type
            column :type_id
            column :resource_id
          end
        end
      end
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :code, input_html: { disabled: f.object.persisted? }
      f.input :parent_code, label: 'Parent School', input_html: { class: 'select2' }, as: :select, collection: School.all.map { |s| [s.name, s.code] }
      f.input :grad_program_code
      f.input :grad_group_code
      f.input :school_day_program_code
      f.input :logo_photo, as: :file
        img src: f.object.logo_photo, class: 'form-preview-image'
      f.input :registrations_enabled
    end

    f.actions
  end

  controller do
    include ActiveAdmin::ViewsHelper

    def find_resource
      scoped_collection.where(code: params[:id]).first!
    end
  end
end
