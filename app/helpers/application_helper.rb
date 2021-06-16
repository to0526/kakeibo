module ApplicationHelper
  def year_months
    dates = (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
    dates = dates.select { |d| d.day == 1 }
    dates.map{|d| d.strftime("%Y/%m")}.reverse
  end

  def displayed_amount(amount)
    if amount < 0
      tag.td amount.to_s(:delimited), align: "right", class: "red"
    else
      tag.td amount.to_s(:delimited), align: "right", class: "blue"
    end
  end
end
