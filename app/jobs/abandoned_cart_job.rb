class AbandonedCartJob < ApplicationJob
  queue_as :default

  def perform
    carts = Cart.where("updated_at < ?", 3.hours.ago)

    carts.each do |cart|
      cart.update(abandoned: true) 
    end
  end
end
