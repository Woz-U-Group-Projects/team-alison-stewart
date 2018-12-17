class ProductsController < ApplicationController
  # Scopes
  has_scope :platform

  def index
    @products = apply_scopes(Product).all.order(:position)
  end
end
