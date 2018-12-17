ActiveAdmin.register Setting do
  menu parent: 'Site'

  config.filters = false

  actions :index

  controller do
    layout 'active_admin'

    def index
      @page_title = 'Settings'
    end

    def update_all
      params[:settings].each do |key, value|
        Setting.send(key + '=', value)
      end

      flash[:notice] = 'Settings have updated successfully.'
      redirect_to admin_settings_path
    end
  end
end
