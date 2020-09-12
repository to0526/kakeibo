class Item < ApplicationRecord
  scope :monthly, -> (date) { where(payed_on: date.beginning_of_month..date.end_of_month) }

  belongs_to :user
  belongs_to :payment_classification
  belongs_to :payment_method

  validates :amount, presence: true
  validates :payed_on, presence: true

  def self.amount_with_date(date:)
    total_amount = 0
    data = monthly(date).order(:payed_on).group(:payed_on).sum(:amount).each_with_object({}) do |(date, amount), hash|
      total_amount += amount
      hash[date.day] = total_amount
    end
    {name: "#{date.strftime('%Y-%m')}", data: data}
  end
end
