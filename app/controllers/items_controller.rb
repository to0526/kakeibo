class ItemsController < ApplicationController
  def index
    @users = User.all
    @payment_methods = PaymentMethod.all
    @payment_classifications = PaymentClassification.order(:sort)

    unless params[:search]
      params[:search] = {
        "year_months": [Date.today.strftime("%Y/%m")],
        "user_ids": @users.ids.map(&:to_s),
        "payment_method_ids": @payment_methods.ids.map(&:to_s),
        "payment_classification_ids": @payment_classifications.ids.map(&:to_s),
      }
    end

    if Item.search(params[:search]).present?
      @items = Item.search(params[:search])
      @items_line_chart = params[:search][:year_months].each_with_object([]) do |year_month, arr|
        arr << @items.line_chart_by_month(year_month)
      end
      @balances_by_month = params[:search][:year_months].each_with_object([]) do |year_month, arr|
        arr << @items.balance_by_month(year_month)
      end
      @balances_by_classification = @items
        .group(:payment_classification_id)
        .sum(:amount).map do |classification_id, amount|
          payment_classification = PaymentClassification.find(classification_id)
          {
            name: payment_classification.name,
            sort: payment_classification.sort,
            amount: amount
          }
        end
      @items = @items.order(payed_on: :desc)
    else
      @items = Item.none
      @items_line_chart = []
      @balances_by_month = []
      @balances_by_classification = []
    end
  end
end
