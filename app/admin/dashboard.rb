ActiveAdmin.register_page 'Dashboard' do
  menu priority: 0

  content title: 'Dashboard' do
    columns do
      column do
        panel 'Common Admin Actions' do
          ul do
            li link_to 'Manage Job Postings', admin_job_postings_path
            li link_to 'Manage FAQs', admin_frequently_asked_questions_path
            li link_to 'Manage Employees', admin_employees_path
            li link_to 'Manage Products', admin_products_path
            li link_to 'Manage Time Trade', admin_time_trades_path
          end
        end
      end

      column do
        panel 'Quick Jump to Edit School Information' do
          render partial: 'school_select'
        end
      end
    end
  end
end
