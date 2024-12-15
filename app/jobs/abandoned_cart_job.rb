class AbandonedCartJob < ApplicationJob
  queue_as :default

  def perform
    Cart.where(abandoned: false).where("created_at <= ?", 3.hours.ago).find_each do |cart|
      cart.update!(abandoned: true)
    end
  end
end
