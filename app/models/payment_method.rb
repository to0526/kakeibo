class PaymentMethod < ApplicationRecord
  validates :name, presence: true
  has_many :items, dependent: :restrict_with_error
end
