class Api::PaymentsController < ApplicationController
  def index
    render json: beginning_of_months.map { |date| Item.amount_with_date(date: date) }
  end
end
