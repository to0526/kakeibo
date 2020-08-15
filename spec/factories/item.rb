FactoryBot.define do
  factory :item do
    payed_on
    amount
    user_id
    payment_classification_id
    payment_method_id
    note { "備考" }
    type { "Payment" }
  end
end
