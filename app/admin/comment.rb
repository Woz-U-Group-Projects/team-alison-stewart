ActiveAdmin.register Comment do
  menu false

  actions :all, except: [:index, :show]

  permit_params :user_id, :owner_id, :owner_type, :text, :custom_text

  config.filters = false

  form partial: 'form'

  controller do
    include ActiveAdmin::ViewsHelper

    before_filter :fetch_owner

    def new
      @comment = Comment.new
      @comment.owner = @owner
    end

    def create
      @comment = Comment.new(permitted_params[:comment])

      @comment.owner = @owner

      if @comment.save
        flash[:success] = 'Comment was successfully created.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot create comment. See errors below'
        render :new
      end
    end

    def update
      if resource.update_attributes(permitted_params[:comment])
        flash[:success] = 'Comment was successfully updated.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot update comment. See errors below'
        render :edit
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Comment was successfully destroyed.'
        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Comment could not be destroyed'
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
