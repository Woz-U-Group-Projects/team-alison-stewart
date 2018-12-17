ActiveAdmin.register Address do
  menu false

  actions :new, :create, :edit, :update, :destroy

  permit_params :owner_id, :owner_type, :address1, :address2, :address3,
    :city, :province, :country, :postal_code

  config.filters = false

  form partial: 'form'

  controller do
    include ActiveAdmin::ViewsHelper

    before_filter :fetch_owner

    def new
      @address = Address.new
      @address.owner = @owner
    end

    def create
      @address = Address.new(permitted_params[:address])

      @address.owner = @owner

      if @address.save
        flash[:success] = 'Address was successfully created.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot create address. See errors below'
        render :new
      end
    end

    def update
      if resource.update_attributes(permitted_params[:address])
        flash[:success] = 'Address was successfully updated.'

        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Cannot update address. See errors below'
        render :edit
      end
    end

    def destroy
      if resource.destroy
        flash[:success] = 'Address was successfully destroyed.'
        redirect_to send("admin_#{@path.singularize}_path", @owner)
      else
        flash[:error] = 'Address could not be destroyed'
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