module ApplicationHelper
  def beginning_of_months
    dates = (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
    dates.select { |d| d.day == 1 }
  end

  def search_payed_on_options
    beginning_of_months.map { |d| [ d.strftime("%Y/%m"), d ] }
  end
end
