require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe AbandonedCartJob, type: :job do
  describe "#perform AbandonedCartJob" do
    let!(:cart1) do
      travel_to 4.hours.ago do
        create(:cart)
      end
    end
    let!(:cart2) { create(:cart) }

    it "Marks carts with more than 3 hours as abandoned" do
      described_class.perform_now

      expect(cart1.reload.abandoned).to be true
      expect(cart2.reload.abandoned).to be false
    end
  end
end
