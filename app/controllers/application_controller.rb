class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :beginning_of_months

  private

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end

  def beginning_of_months
    dates = (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
    dates.select { |d| d.day == 1 }
  end
end
