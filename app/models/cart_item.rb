class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  after_create :update_cart_total_price
  after_update :update_cart_total_price
  after_destroy :update_cart_total_price

  private

  def update_cart_total_price
    cart.update_total_price
  end
end
