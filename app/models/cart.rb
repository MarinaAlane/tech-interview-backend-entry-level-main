class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id, quantity)
    product = Product.find(product_id)

    cart_item = cart_items.find_or_initialize_by(product_id: product_id, quantity: quantity)
    cart_item.save!

    cart_item
  end
end
