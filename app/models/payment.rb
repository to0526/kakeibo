class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :payment_classification
  belongs_to :payment_method

  validates :amount, presence: true
end
