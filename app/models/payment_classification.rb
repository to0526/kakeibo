class PaymentClassification < ApplicationRecord
  enum purpose: { required: 0, enjoyment: 1 }
  validates :name, presence: true
  validates :sort, presence: true
  has_many :payments, dependent: :restrict_with_error
end
