class ItemsController < ApplicationController
  def index
    if params[:year_months].present?
      @items = Item.where_year_months(params[:year_months]).order(payed_on: :desc)
      @items_line_chart = params[:year_months].each_with_object([]) do |year_month, arr|
        arr << Item.line_chart_by_month(year_month)
      end
    else
      @items = Item.none
    end
  end
end
