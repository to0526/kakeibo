class ItemsController < ApplicationController
  def index
    if params[:year_months].present?
      @items = Item.where_year_months(params[:year_months]).order(payed_on: :desc)
    else
      @items = Item.none
    end
  end
end
