ActiveAdmin.register Node do
  menu false

  actions :all, except: [:index, :show]

  permit_params :type, :owner_id, :owner_type,
    :x, :y, :width, :height, :name, :text, :font_family,
    :point_size, :node_photo, :crop_x, :crop_y,
    :crop_width, :crop_height, :color, :junior_field,
    :position, :alignment, :mask, :uppercase,
    phrases_attributes: [:id, :_destroy, :node_id, :name, :junior_field, :prefix, :suffix, :position]

  config.filters = false

  form partial: 'form'

  controller do
    include ActiveAdmin::ViewsHelper

    before_filter :fetch_owner

    def new
      @node = Node.new
      @node.owner = @owner
    end

    def create
      @node = Node.new(permitted_params[:node])

      @node.owner = @owner

      if @node.save
        flash[:success] = 'Node was successfully created.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot create node. See errors below'
        render :new
      end
    end

    def update
      if resource.update_attributes(permitted_params[:node])
        flash[:success] = 'Node was successfully updated.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot update node. See errors below'
        render :edit
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Node was successfully destroyed.'
        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Node could not be destroyed'
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