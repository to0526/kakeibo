class ItemsController < ApplicationController
  def index
    @users = User.all
    @payment_methods = PaymentMethod.all
    @payment_classifications = PaymentClassification.all

    unless params[:search]
      params[:search] = {
        "year_months": last_three_year_months,
        "user_ids": @users.ids.map(&:to_s),
        "payment_method_ids": @payment_methods.ids.map(&:to_s),
        "payment_classification_ids": @payment_classifications.ids.map(&:to_s),
      }
    end

    if Item.search(params[:search]).present?
      @items = Item.search(params[:search]).order(payed_on: :desc)
      @items_line_chart = params[:search][:year_months].each_with_object([]) do |year_month, arr|
        arr << @items.line_chart_by_month(year_month)
      end
    else
      @items = Item.none
      @items_line_chart = []
    end
  end

  private

  def last_three_year_months
    today = Date.today
    [today, today-1.month, today-2.months].map do |date|
      date.strftime("%Y/%m")
    end
  end
end
