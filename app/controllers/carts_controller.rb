class CartsController < ApplicationController
  # Cria ou busca um carrinho, adiciona produtos e retorna o estado do carrinho
  def create
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    # Recupera ou cria o carrinho baseado na sessão
    cart = Cart.find_or_create_by(id: session[:cart_id] || session.id)
    puts cart.id, '0000000000000000'
    puts product_id, '21111111111111'
    # Adiciona o produto ao carrinho
    create_cart = cart.add_product(product_id, quantity) # Correção aqui

    render json: { create_cart: create_cart }
  end
end
