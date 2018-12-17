ActiveAdmin.register ElectronicMarketing do
  menu parent: 'Manage Schools'

  permit_params  :grad_program_code, :grad_group_code, :school_day_program_code, :program_slug, :school_id, :name, :file, :position

  filter :name

  index do
    column 'Name' do |electronic_marketing|
      link_to electronic_marketing.name, admin_electronic_marketing_path(electronic_marketing)
    end
    column :school
    column :grad_program_code
    column :grad_group_code
    column :school_day_program_code
    column 'Program' do |electronic_marketing|
      Program.find(electronic_marketing.program_slug)&.name
    end
    actions
  end

  show do |electronic_marketing|
    attributes_table do
      row(:id)
      row(:name)
      row(:school)
      row(:grad_program_code)
      row(:grad_group_code)
      row(:school_day_program_code)
      row 'Program' do |electronic_marketing|
        Program.find(electronic_marketing.program_slug)&.name
      end
      row 'File' do |electronic_marketing|
        file_tag(electronic_marketing.file.path, electronic_marketing.file.url) if electronic_marketing.file
      end
      row(:position)
      row(:created_at)
      row(:updated_at)
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :grad_program_code, hint: 'This should match the grad program code being used in Highrise.'
      f.input :grad_group_code, hint: 'This should match the grad group code being used in Highrise.'
      f.input :school_day_program_code, hint: 'This should match the school day program code being used in Highrise.'
      f.input :school_id, label: 'School', input_html: { class: 'select2' }, as: :select, collection: School.all.map { |s| [s.name, s.id] }, hint: 'If this school is a university faculty, please choose the PARENT SCHOOL and NOT the faculty name i.e. for UBC - Law choose University of British Columbia'
      f.input :program_slug, as: :select, collection: Program.all.map { |p| [p.name, p.slug] }
      f.input :file, as: :file
      f.input :position
    end

    f.actions
  end
end
