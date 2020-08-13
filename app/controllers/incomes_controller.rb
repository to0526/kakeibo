class IncomesController < ApplicationController
  before_action :set_income, only: [:edit, :update, :destroy]

  def new
    @income = Income.new
  end

  def edit
  end

  def create
    @income = Income.new(income_params)

    if @income.save
      redirect_to items_url, notice: '収入を登録しました'
    else
      render :new
    end
  end

  def update
    if @income.update(income_params)
      redirect_to items_url, notice: '収入を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @income.destroy
    redirect_to items_url, notice: '収入を削除しました'
  end

  private
    def set_income
      @income = Income.find(params[:id])
    end

    def income_params
      params.require(:income).permit(:payed_on, :amount, :user_id, :payment_classification_id, :payment_method_id, :note)
    end
end
