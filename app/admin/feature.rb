ActiveAdmin.register Feature do
  menu false

  actions :new, :create, :edit, :update, :destroy

  permit_params :owner_id, :owner_type, :title, :description,
    :icon, :position

  config.filters = false

  form partial: 'form'

  controller do
    include ActiveAdmin::ViewsHelper

    before_filter :fetch_owner

    def new
      @feature = Feature.new
      @feature.owner = @owner
    end

    def create
      @feature = Feature.new(permitted_params[:feature])

      @feature.owner = @owner

      if @feature.save
        flash[:success] = 'Feature was successfully created.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot create feature. See errors below'
        render :new
      end
    end

    def update
      if resource.update_attributes(permitted_params[:feature])
        flash[:success] = 'Feature was successfully updated.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot update feature. See errors below'
        render :edit
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Feature was successfully destroyed.'
        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Feature could not be destroyed'
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