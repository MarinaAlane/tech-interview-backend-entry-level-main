require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { create(:cart) }
  let(:product) { create(:product, price: 10.00) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2) }

  it 'belongs to a cart' do
    expect(cart_item.cart).to eq(cart)
  end

  it 'belongs to a product' do
    expect(cart_item.product).to eq(product)
  end

  describe '#update_cart_total_price' do
    it 'updates the cart total price after create' do
      expect {
        create(:cart_item, cart: cart, product: product, quantity: 3)
      }.to change { cart.reload.total_price }.by(30.0)
    end

    it 'updates the cart total price after update' do
      cart.update_total_price

      expect {
        cart_item.update(quantity: 5)
      }.to change { cart.reload.total_price }.by(50.0)
    end
  end
end