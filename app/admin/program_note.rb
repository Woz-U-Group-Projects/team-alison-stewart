ActiveAdmin.register ProgramNote do
  menu false

  actions :new, :create, :edit, :update, :destroy

  permit_params :text, :program_slug

  config.filters = false

  form partial: 'form'

  controller do
    before_filter :fetch_school

    def new
      @program_note = ProgramNote.new
      @program_note.school = @school
    end

    def create
      @program_note = ProgramNote.new(permitted_params[:program_note])

      @program_note.school = @school

      if @program_note.save
        flash[:success] = 'Program note was successfully created.'

        redirect_to admin_school_path(@school)
      else
        flash[:error] = 'Cannot create program note. See errors below'
        render :new
      end
    end

    def update
      if resource.update_attributes(permitted_params[:program_note])
        flash[:success] = 'Program note was successfully updated.'

        redirect_to admin_school_path(@school)
      else
        flash[:error] = 'Cannot update program note. See errors below'
        render :edit
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Program note was successfully destroyed.'
        redirect_to admin_school_path(@school)
      else
        flash[:error] = 'Program note could not be destroyed'
        redirect_to admin_school_path(@school)
      end
    end

    private

    def fetch_school
      @school = School.find_by_code!(params[:school_id])
    end
  end
end
