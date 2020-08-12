class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    unless params[:q]
      params[:q] = {}
      params[:q][:payed_on_gteq] = Date.today.beginning_of_month.to_s
      params[:q][:payed_on_lteq] = Date.today.end_of_month.to_s
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

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.fetch(:item, {})
    end
end
