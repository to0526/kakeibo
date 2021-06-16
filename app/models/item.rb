class Item < ApplicationRecord
  belongs_to :user
  belongs_to :payment_classification
  belongs_to :payment_method

  validates :amount, presence: true
  validates :payed_on, presence: true

  scope :where_year_months, -> (year_months) do
    return none unless year_months
    where_args = year_months.map do |year_month|
      from = Date.parse(year_month).beginning_of_month
      to   = Date.parse(year_month).end_of_month
      "(payed_on BETWEEN '#{from}' AND '#{to}')"
    end.join(" OR ")
    where(where_args)
  end

  scope :search, -> (search_params) do
    where_year_months(search_params[:year_months])
      .where(user_id: search_params[:user_ids])
      .where(payment_method_id: search_params[:payment_method_ids])
      .where(payment_classification_id: search_params[:payment_classification_ids])
  end

  scope :amount_group_by_day, -> (year_month) do
    from = Date.parse(year_month).beginning_of_month
    to   = Date.parse(year_month).end_of_month
    where("(payed_on BETWEEN '#{from}' AND '#{to}')")
      .group("payed_on")
      .order(payed_on: :asc)
  end

  def self.line_chart_by_month(year_month)
    items = amount_group_by_day(year_month).sum(:amount)
    from = Date.parse(year_month).beginning_of_month.day
    to   = Date.parse(year_month).end_of_month.day
    total_amount = 0
    data = {}
    (from..to).to_a.each do |day|
      amount_by_day = (items[Date.parse("#{year_month}/#{day}")] || 0)
      total_amount += amount_by_day
      data[day] = total_amount
    end
    { name: year_month, data: data }
  end

  def self.balance_by_month(year_month)
    balance = amount_group_by_day(year_month).sum(:amount).values[0] || 0
    income  = amount_group_by_day(year_month).where(type: "Income").sum(:amount).values[0] || 0
    payment = amount_group_by_day(year_month).where(type: "Payment").sum(:amount).values[0] || 0
    { year_month: year_month, payment: payment, income: income, balance: balance }
  end
end
