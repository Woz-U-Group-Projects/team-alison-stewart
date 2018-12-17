ActiveAdmin.register ImportantDateTypeProgram do
  menu false

  actions :new, :create, :destroy

  permit_params :program_slug

  config.filters = false

  form partial: 'form'

  controller do
    before_filter :fetch_important_date_type

    def new
      @important_date_type_program = ImportantDateTypeProgram.new
      @important_date_type_program.important_date_type = @important_date_type
    end

    def create
      @important_date_type_program = ImportantDateTypeProgram.new(permitted_params[:important_date_type_program])

      @important_date_type_program.important_date_type = @important_date_type

      if @important_date_type_program.save
        flash[:success] = 'Important date type program was successfully created.'

        redirect_to admin_important_date_type_path(@important_date_type)
      else
        flash[:error] = 'Cannot create Important date type program. See errors below'
        render :new
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Important date type program was successfully destroyed.'
        redirect_to admin_important_date_type_path(@important_date_type)
      else
        flash[:error] = 'Important date type program could not be destroyed'
        redirect_to admin_important_date_type_path(@important_date_type)
      end
    end

    private

    def fetch_important_date_type
      @important_date_type = ImportantDateType.find(params[:important_date_type_id])
    end
  end
end
