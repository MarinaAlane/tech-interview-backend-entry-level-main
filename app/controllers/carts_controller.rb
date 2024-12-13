class CartsController < ApplicationController
  def create
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    product = Product.find(product_id)
    
    cart = Cart.find_or_create_by(session_id: session.id.to_s)
    cart.add_product(product, quantity)

    render json: {
      id: cart.id,
      products: cart.list_items,
      total_price: cart.sum_price(product.price, quantity)
    }
  end
end
