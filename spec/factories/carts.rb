FactoryBot.define do
  factory :cart do
    total_price { 1500.00} 
    updated_at { Time.zone.now }
    abandoned { false }
  end
end
