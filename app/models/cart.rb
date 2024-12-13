class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product, quantity)
    cart_item = cart_items.find_or_initialize_by(product_id: product.id, quantity: quantity)

    cart_item.save!
  end

  def sum_price(quantity, price)
    cart_items.joins(:product).sum('products.price * cart_items.quantity')
  end
  
  def list_items
    cart_items.map do |item|
      {
        id: item.product.id,
        name: item.product.name,
        quantity: item.quantity,
        unit_price: item.product.price,
        total_price: item.quantity * item.product.price
      }
    end
  end
end
