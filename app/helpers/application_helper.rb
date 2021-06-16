module ApplicationHelper
  def year_months
    dates = (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
    dates = dates.select { |d| d.day == 1 }
    dates.map{|d| d.strftime("%Y/%m")}.reverse
  end
end
