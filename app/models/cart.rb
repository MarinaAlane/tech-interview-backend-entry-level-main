class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  after_create :update_total_price 
  validates :total_price, presence: { message: "must be greater than or equal to 0" }
  validates :total_price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def add_product(product, quantity)
    cart_item = cart_items.find_or_initialize_by(product_id: product.id, quantity: quantity)
    cart_item.save!
  end

  def update_product(product, quantity)
    cart_item = cart_items.find_by(product: product)
    if cart_item
      if quantity > 0
        cart_item.update!(quantity: quantity) 
      else
        cart_item.destroy!
      end
    end
  end

  def remove_product(product)
    cart_items.find_by(product: product)&.destroy!
  end

  def list_items
    cart_items.includes(:product).map do |item|
      {
        id: item.product.id,
        name: item.product.name,
        quantity: item.quantity,
        unit_price: item.product.price,
        total_price: item.quantity * item.product.price
      }
    end
  end

  def update_total_price
    self.total_price = cart_items.joins(:product).sum('products.price * cart_items.quantity')
    save!
  end

  def abandoned?
    abandoned
  end

  def mark_as_abandoned
    update(abandoned: true)
  end
end
