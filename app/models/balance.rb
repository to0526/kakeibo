class Balance
  attr :year_month

  def initialize(year_month:, user_ids: [], payment_classification_ids: [], payment_method_ids: [])
    @year_month = year_month
    @user_ids = user_ids
    @payment_classification_ids = payment_classification_ids
    @payment_method_ids = payment_method_ids
  end

  def payment
    Payment.where(where_args).sum(:amount)
  end

  def income
    Income.where(where_args).sum(:amount)
  end

  def balance
    # paymentはマイナスで保存されるので足せばok
    payment + income
  end

  private

  def where_args
    date = Date.parse(year_month).beginning_of_month
    args = { payed_on: date.beginning_of_month..date.end_of_month }
    args.merge!({ user_id: @user_ids }) if @user_ids.present?
    args.merge!({ payment_classification_id: @payment_classification_ids }) if @payment_classification_ids.present?
    args.merge!({ payment_method_id: @payment_method_ids }) if @payment_method_ids.present?
    args
  end
end
