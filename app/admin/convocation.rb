ActiveAdmin.register Convocation do
  menu false

  actions :new, :create, :edit, :update, :destroy

  permit_params :ceremony

  config.filters = false

  form partial: 'form'

  controller do
    before_filter :fetch_school

    def new
      @convocation = Convocation.new
      @convocation.school = @school
    end

    def create
      @convocation = Convocation.new(permitted_params[:convocation])

      @convocation.school = @school

      if @convocation.save
        flash[:success] = 'Convocation was successfully created.'

        redirect_to admin_school_path(@school)
      else
        flash[:error] = 'Cannot create convocation. See errors below'
        render :new
      end
    end

    def update
      if resource.update_attributes(permitted_params[:convocation])
        flash[:success] = 'Convocation was successfully updated.'

        redirect_to admin_school_path(@school)
      else
        flash[:error] = 'Cannot update convocation. See errors below'
        render :edit
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Convocation was successfully destroyed.'
        redirect_to admin_school_path(@school)
      else
        flash[:error] = 'Convocation could not be destroyed'
        redirect_to admin_school_path(@school)
      end
    end

    private

    def fetch_school
      @school = School.find_by_code!(params[:school_id])
    end
  end
end
