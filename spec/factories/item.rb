FactoryBot.define do
  factory :item do
    payed_on { Date.today }
    amount { 0 }
    user
    payment_classification
    payment_method
    note { "備考" }
    type { "Payment" }
  end
end
