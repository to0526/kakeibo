class ItemsController < ApplicationController
  def index
    if params[:year_months].present?
      @items = Item.where_year_months(params[:year_months]).order(payed_on: :desc)

      @items_line_chart = []
      params[:year_months].each do |year_month|
        total_amount = 0
        h = {}
        h[:name] = year_month
        items = Item.where_year_month(year_month).group("payed_on").order(payed_on: :asc).sum(:amount)
        from = Date.parse(year_month).beginning_of_month.day
        to   = Date.parse(year_month).end_of_month.day
        h[:data] = {}
        (from..to).to_a.each do |day|
          total_amount += (items[Date.parse("#{year_month}/#{day}")] || 0)
          h[:data][day] = total_amount
        end
        @items_line_chart << h
      end
    else
      @items = Item.none
    end
  end
end
