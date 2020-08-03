class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :payment_classification
  belongs_to :payment_method

  validates :amount, presence: true
  validates :payed_on, presence: true
end
