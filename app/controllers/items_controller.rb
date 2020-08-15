class ItemsController < ApplicationController
  def index
    if params[:q].nil?
      params[:q] = {}
      params[:q][:payed_on_gteq] = Date.today.beginning_of_month.to_s
      params[:q][:payed_on_lteq] = Date.today.end_of_month.to_s
    elsif params[:q][:payed_on_gteq].present?
      params[:q][:payed_on_lteq] = params[:q][:payed_on_gteq].to_date.end_of_month.to_s
    end
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).order(payed_on: :desc)
    @items_total_amount = @items.map{|item|item.amount}.sum.to_s(:delimited)
    @items_amount_with_classification =
      PaymentClassification.all.order(:sort).each_with_object([]) do |payment_classification, arr|
        arr << {
          payment_classification: payment_classification.name,
          amount: @items.where(payment_classification_id: payment_classification.id).map{|item|item.amount}.sum.to_s(:delimited)
        }
      end
  end
end
