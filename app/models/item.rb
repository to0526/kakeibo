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
    amount_with_date = where(payed_on: dates).group(:payed_on).sum(:amount)
    amount_by_day = dates.map do |date|
      amount = amount_with_date[date] || 0
      total_amount_until_date += amount
      total_amount_until_date
    end
    color =
      case date.month
      when 1  then "#E60012"
      when 2  then "#E39800"
      when 3  then "#FFF100"
      when 4  then "#8FC31F"
      when 5  then "#009944"
      when 6  then "#009E96"
      when 7  then "#00A0E9"
      when 8  then "#0068B7"
      when 9  then "#1D2088"
      when 10 then "#920783"
      when 11 then "#E4007F"
      when 12 then "#E5004F"
      end
    {
      label: "#{date.strftime('%Y/%m')}",
      borderColor: color,
      data: amount_by_day,
      fill: false,
    }
  end
end
