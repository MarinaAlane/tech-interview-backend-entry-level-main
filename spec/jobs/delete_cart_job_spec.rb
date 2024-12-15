require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe DeleteCartJob, type: :job do
  describe "#perform DeleteCartJob" do
    let!(:old_cart) do
      travel_to 8.days.ago do
        create(:cart)
      end
    end
    let!(:recent_cart) { create(:cart, updated_at: 6.days.ago) }

    it "Removes carts with more than 7 days of inactivity" do
      expect { described_class.perform_now }.to change { Cart.exists?(old_cart.id) }.from(true).to(false)
    end

    it "Does not remove recently updated carts" do
      expect { described_class.perform_now }.not_to change { Cart.exists?(recent_cart.id) }
    end

    it "Does not raise errors if there are no carts to delete" do
      Cart.destroy_all
      expect { described_class.perform_now }.not_to raise_error
    end
  end
end
