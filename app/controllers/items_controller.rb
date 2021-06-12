class ItemsController < ApplicationController
  def index
    payed_on_where_args = ""
    if params[:year_months].present?
      payed_on_where_args = params[:year_months].map do |year_month|
        from = Date.parse(year_month).beginning_of_month
        to   = Date.parse(year_month).end_of_month
        "(payed_on BETWEEN '#{from}' AND '#{to}')"
      end.join(" OR ")
    end
    @items = Item.where(payed_on_where_args).order(payed_on: :desc)
  end
end
