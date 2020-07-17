class PaymentClassification < ApplicationRecord
  enum purpose: { required: 0, enjoyment: 1 }
  validates :name, presence: true
end
