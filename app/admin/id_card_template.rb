ActiveAdmin.register IdCardTemplate do
  menu parent: 'Manage Schools'

  permit_params :name, :school_id, :base_photo

  action_item :copy, only: :show do
    link_to 'Copy', copy_admin_id_card_template_path(resource), method: :post
  end

  member_action :copy, method: :post do
    new_template = resource.dup

    new_template.school = nil
    new_template.base_photo = resource.base_photo
    new_template.name = resource.name + ' Copy'

    new_template.save!

    # # Generate all the nodes
    resource.nodes.each do |node|
      new_node = node.dup

      new_node.owner = nil

      new_node.mask = node.mask

      new_template.nodes << new_node

      new_node.save!

      # Copy the phrases
      node.phrases.each do |phrase|
        new_phrase = phrase.dup

        new_phrase.node = nil

        new_node.phrases << new_phrase

        new_phrase.save!
      end
    end

    new_template.save!

    flash[:notice] = 'Successfully copied ID Card Template. You are now viewing the copy.'
    redirect_to admin_id_card_template_path(new_template)
  end

  filter :school, collection: proc { School.order(:name) }
  filter :created_at
  filter :updated_at
  filter :base_photo
  filter :name

  index do
    column(:name) { |ict| link_to ict.name, admin_id_card_template_path(ict) }
    column :school, sortable: :'schools.name'
    column :updated_at
    actions
  end

  show do |id_card_template|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:name)
          row(:school)
          row 'Base Photo' do |id_card_template|
            image_tag id_card_template.base_photo
          end
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Nodes' do
          render partial: 'admin/nodes/table', locals: { nodes: id_card_template.nodes }
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :school_id, as: :select, input_html: { class: 'select2' }, collection: School.all.map { |s| [s.name, s.id] }
      f.input :base_photo, as: :file
        img src: f.object.base_photo, class: 'form-preview-image'
    end

    f.actions
  end

  controller do
    def scoped_collection
      IdCardTemplate.includes(:school)
    end
  end
end
