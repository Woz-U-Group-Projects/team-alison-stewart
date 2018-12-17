ActiveAdmin.register JobPosting do
  menu parent: 'Artona'

  permit_params :name, :expiry_date, :job_type_id, :title,
    :responsibilities, :requirements, :position

  filter :job_type, collection: proc { JobType.order(:name)}
  filter :name
  filter :expiry_date
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column 'Name' do |posting|
      link_to posting.name, admin_job_posting_path(posting)
    end
    column :title
    column 'Type' do |job_posting|
      link_to job_posting.job_type.name, admin_job_type_path(job_posting.job_type) if job_posting.job_type
    end
    column :position
    column :expiry_date
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :job_type_id, as: :select, collection: JobType.all.order(:name).map { |pt| [pt.name, pt.id] }
      f.input :title
      f.input :expiry_date, as: :date_select, hint: 'leave this blank for the job posting to never expire'
      f.input :responsibilities, as: :html_editor, hint: 'use a bulleted list for best display results'
      f.input :requirements, as: :html_editor, hint: 'use a bulleted list for best display results'
      f.input :position
    end

    f.actions
  end
end
