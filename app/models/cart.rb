class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product, quantity)
    cart_item = cart_items.find_or_initialize_by(product_id: product.id, quantity: quantity)

    cart_item.save!
  end

  def updated_product(product, quantity)
    cart_item = cart_items.find_or_initialize_by(product_id: product)
    if cart_item.new_record? || quantity > cart_item.quantity
      cart_item.quantity = quantity 
      cart_item.save!
    end
  end

  def sum_price(quantity, price)
    cart_items.joins(:product).sum('products.price * cart_items.quantity')
  end

  def delete_product(product)
    cart_item = CartItem.where(product_id: product.id)

    cart_item.delete(cart_item)
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
