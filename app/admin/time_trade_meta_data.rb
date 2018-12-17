ActiveAdmin.register TimeTradeMetaData, as: 'Time Trade' do
  menu label: 'Time Trade', parent: 'Manage Bookings'

  config.filters = false

  config.sort_order = 'code'

  actions :index, :show

  action_item :new_coupon, only: :index do
    link_to 'Upload new Time Trade Data', new_admin_time_trade_import_path
  end

  index title: 'Time Trade' do
    column :school
    column 'Code' do |time_trade_meta_data|
      time_trade_meta_data.school.code
    end
    column 'Campaign ID' do |time_trade_meta_data|
      link_to time_trade_meta_data.campaign_id, admin_time_trade_path(time_trade_meta_data)
    end
    column 'Group ID' do |time_trade_meta_data|
      time_trade_meta_data.appointment_type_group_id
    end
  end

  show do |time_trade_meta_data|
    columns do
      column do
        attributes_table do
          row(:id)
          row(:school)
          row(:campaign_id)
          row(:appointment_type_group_id)
          row(:company_name)
          row(:created_at)
          row(:updated_at)
        end
      end

      column do
        panel 'Appointment Types' do
          table_for time_trade_meta_data.appointment_types do
            column(:type_id)
            column(:photo_type)
            column(:resource_id)
          end
        end
      end
    end
  end
end
