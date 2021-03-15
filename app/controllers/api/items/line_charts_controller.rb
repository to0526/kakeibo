class Api::Items::LineChartsController < ApplicationController
  def index
    @items = Item.all
  end
end
