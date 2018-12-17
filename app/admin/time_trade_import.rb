ActiveAdmin.register TimeTradeImport do
  menu false

  permit_params :file

  actions :new, :create

  form html: { multipart: true } do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :file, as: :file
    end

    f.actions do
      f.action :submit
      link_to 'Cancel', admin_time_trades_path
    end
  end

  controller do
    def create
      @time_trade_import = TimeTradeImport.new(permitted_params[:time_trade_import])

      if @time_trade_import.save
        @time_trade_import.process

        flash[:notice] = 'Successfully created Time trade import. Importer will begin soon.'
        redirect_to admin_time_trades_path
      else
        flash[:error] = 'Cannot create time trade import. See errors below'
      end
    end
  end
end
