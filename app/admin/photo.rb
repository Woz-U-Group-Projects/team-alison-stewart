ActiveAdmin.register Photo do
  menu false

  actions :new, :create, :destroy

  permit_params :owner_id, :owner_type, :file_name, :position, :title

  config.filters = false

  form partial: 'form'

  controller do
    include ActiveAdmin::ViewsHelper

    before_filter :fetch_owner

    def new
      @photo = Photo.new
      @photo.owner = @owner
    end

    def create
      @photo = Photo.new(permitted_params[:photo])

      @photo.owner = @owner

      if @photo.save
        flash[:success] = 'Photo was successfully created.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot create photo. See errors below'
        render :new
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Photo was successfully destroyed.'
        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Photo could not be destroyed'
        redirect_to send("admin_#{@path.singularize}_path", @owner)
      end
    end

    private

    def fetch_owner
      @clazz  = who_do_i_belong_to?.to_s.camelize.constantize
      @param  = (who_do_i_belong_to?.to_s + '_id').to_sym
      @path   = who_do_i_belong_to?.to_s

      @owner = @clazz.find(params[@param])
    end
  end
end