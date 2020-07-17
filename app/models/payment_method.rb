class PaymentMethod < ApplicationRecord
  validates :name, presence: true
  has_many :payments
end
