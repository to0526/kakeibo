module ApplicationHelper
  def search_payed_on_options
    dates = (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
    beginning_of_months = dates.select { |d| d.day == 1 }
    beginning_of_months.map { |d| [ d.strftime("%Y/%m"), d ] }
  end
end
