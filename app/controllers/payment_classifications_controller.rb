class PaymentClassificationsController < ApplicationController
  before_action :set_payment_classification, only: [:show, :edit, :update, :destroy]

  def index
    @payment_classifications = PaymentClassification.all.order(:sort)
  end

  def show
  end

  def new
    @payment_classification = PaymentClassification.new
  end

  def edit
  end

  def create
    @payment_classification = PaymentClassification.new(payment_classification_params)

    if @payment_classification.save
      redirect_to @payment_classification, notice: '支払い分類を作成しました'
    else
      render :new
    end
  end

  def update
    if @payment_classification.update(payment_classification_params)
      redirect_to @payment_classification, notice: '支払い分類を更新しました'
    else
      render :edit
    end
  end

  def destroy
    if @payment_classification.destroy
      redirect_to payment_classifications_url, notice: '支払い分類を削除しました'
    else
      redirect_to payment_classifications_url, alert: '支払い分類を削除できませんでした'
    end
  end

  private
    def set_payment_classification
      @payment_classification = PaymentClassification.find(params[:id])
    end

    def payment_classification_params
      params.require(:payment_classification).permit(:purpose, :name, :sort)
    end
end
