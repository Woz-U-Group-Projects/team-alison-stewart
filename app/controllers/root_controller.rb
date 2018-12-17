class RootController < ApplicationController
  def show
    # Get all the default look books
    @look_books = LookBook.where('school_id IS NULL')

    # Get all the services
    @services = Service.all.order(:position)
  end
end
