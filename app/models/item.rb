class Item < ApplicationRecord
  scope :monthly, -> (date) { where(payed_on: date.beginning_of_month..date.end_of_month) }

  belongs_to :user
  belongs_to :payment_classification
  belongs_to :payment_method

  validates :amount, presence: true
  validates :payed_on, presence: true
end
