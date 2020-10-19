class Item < ApplicationRecord
  scope :monthly, -> (date) { where(payed_on: date.beginning_of_month..date.end_of_month) }

  belongs_to :user
  belongs_to :payment_classification
  belongs_to :payment_method

  validates :amount, presence: true
  validates :payed_on, presence: true

  def self.amount_with_date(date:)
    total_amount_until_date = 0
    dates = (date.beginning_of_month..date.end_of_month).to_a
    amount_by_day = dates.map do |date|
      total_amount_until_date += where(payed_on: date).sum(:amount)
      total_amount_until_date
    end
    {label: "#{date.strftime('%Y/%m')}", data: amount_by_day}
  end
end
