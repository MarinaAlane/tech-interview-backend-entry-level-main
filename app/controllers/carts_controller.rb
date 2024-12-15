class CartsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product_id].to_i)
    @cart.add_product(product, params[:quantity].to_i)

    render json: cart_json
  end

  def show
    render json: cart_json
  end

  def update
    product = Product.find(params[:product_id].to_i)
    @cart.update_product(product, params[:quantity].to_i)

    render json: cart_json
  end

  def delete
    product = Product.find(params[:product_id].to_i)
    @cart.remove_product(product)

    render json: cart_json
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(session_id: session.id.to_s)
  end

  def cart_json
    {
      id: @cart.id,
      products: @cart.list_items,
      total_price: @cart.total_price
    }
  end
end
