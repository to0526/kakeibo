class PaymentsController < ApplicationController
  before_action :set_payment, only: [:edit, :update, :destroy]

  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to new_payment_url, notice: '支払を登録しました'
    else
      render :new
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to items_url, notice: '支払を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to items_url, notice:  '支払を削除しました'
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:payed_on, :amount, :user_id, :payment_classification_id, :payment_method_id, :note)
    end
end
