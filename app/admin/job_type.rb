ActiveAdmin.register JobType do
  menu parent: 'Artona'

  permit_params :name, :position

  filter :name

  config.sort_order = 'position'

  index do
    selectable_column
    column 'Name' do |job_type|
      link_to job_type.name, admin_job_type_path(job_type)
    end
    column :position
    actions
  end

  show do |job_type|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:name)
          row(:position)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Job Postings' do
          table_for job_type.job_postings do
            column(:job_post_title) { |job_posting| link_to job_posting.title, admin_job_posting_path(job_posting) }
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :position
    end

    f.actions
  end
end
