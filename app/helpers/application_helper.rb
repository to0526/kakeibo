module ApplicationHelper
  def search_payed_on_options
    beginning_of_months.map { |d| [ d.strftime("%Y/%m"), d ] }
  end
end
