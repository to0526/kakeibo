FactoryBot.define do
  factory :income do
    payed_on { Date.today }
    amount { 100_000 }
    user
    payment_classification
    payment_method
    note { "備考" }
  end
end
