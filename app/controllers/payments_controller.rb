class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @q = Payment.ransack(params[:q])
    @payments = @q.result(distinct: true).order(payed_on: :desc)
  end

  def show
  end

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to @payment, notice: '支払金額を作成しました'
    else
      render :new
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to @payment, notice: '支払金額を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_url, notice:  '支払金額を削除しました'
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:payed_on, :amount, :user_id, :payment_classification_id, :payment_method_id, :note)
    end
end
