class CartsController < ApplicationController
  def create
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    cart = Cart.find_or_create_by(id: session[:cart_id] || session.id)
    create_cart = cart.add_product(product_id, quantity)

    render json: { create_cart: create_cart }
  end
end
