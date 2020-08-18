FactoryBot.define do
  factory :payment do
    payed_on { Date.today }
    amount { -10_000 }
    user
    payment_classification
    payment_method
    note { "備考" }
  end
end
