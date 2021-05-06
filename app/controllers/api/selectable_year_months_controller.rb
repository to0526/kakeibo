class Api::SelectableYearMonthsController < ApplicationController
  def index
    @year_months = dates.select { |d| d.day == 1 }.map { |d| d.strftime("%Y/%m") }
  end

  private

  def dates
    (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
  end
end
