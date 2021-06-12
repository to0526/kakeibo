class Item < ApplicationRecord
  scope :monthly, -> (date) { where(payed_on: date.beginning_of_month..date.end_of_month) }

  scope :where_year_months, -> (year_months) do
    where_args = year_months.map do |year_month|
      from = Date.parse(year_month).beginning_of_month
      to   = Date.parse(year_month).end_of_month
      "(payed_on BETWEEN '#{from}' AND '#{to}')"
    end.join(" OR ")
    where(where_args)
  end

  belongs_to :user
  belongs_to :payment_classification
  belongs_to :payment_method

  validates :amount, presence: true
  validates :payed_on, presence: true
end
