class PaymentMethod < ApplicationRecord
  validates :name, presence: true
  has_many :payments, dependent: :restrict_with_error
end
