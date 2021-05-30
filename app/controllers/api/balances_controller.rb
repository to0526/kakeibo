class Api::BalancesController < ApplicationController
  def index
    @balances = []
    if params[:year_months].present?
      params[:year_months].each do |year_month|
        @balances << Balance.new(year_month: year_month,
                                 user_ids: params[:user_ids],
                                 payment_classification_ids: params[:payment_classification_ids],
                                 payment_method_ids: params[:payment_method_ids])
      end
    end
    @balances
  end
end
