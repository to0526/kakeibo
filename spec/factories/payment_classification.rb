FactoryBot.define do
  factory :payment_classification do
    purpose { :required }
    name { "食費" }
    sort { 1 }
  end
end
