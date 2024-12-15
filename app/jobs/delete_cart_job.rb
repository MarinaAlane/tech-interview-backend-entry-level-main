class DeleteCartJob < ApplicationJob
  queue_as :default

  def perform()
        carts = Cart.where("updated_at < ?", 7.days.ago)

    carts.each do |cart|
      cart.destroy()
    end
  end
end
