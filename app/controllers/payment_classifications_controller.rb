class PaymentClassificationsController < ApplicationController
  before_action :set_payment_classification, only: [:show, :edit, :update, :destroy]

  # GET /payment_classifications
  # GET /payment_classifications.json
  def index
    @payment_classifications = PaymentClassification.all
  end

  # GET /payment_classifications/1
  # GET /payment_classifications/1.json
  def show
  end

  # GET /payment_classifications/new
  def new
    @payment_classification = PaymentClassification.new
  end

  # GET /payment_classifications/1/edit
  def edit
  end

  # POST /payment_classifications
  # POST /payment_classifications.json
  def create
    @payment_classification = PaymentClassification.new(payment_classification_params)

    respond_to do |format|
      if @payment_classification.save
        format.html { redirect_to @payment_classification, notice: 'Payment classification was successfully created.' }
        format.json { render :show, status: :created, location: @payment_classification }
      else
        format.html { render :new }
        format.json { render json: @payment_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_classifications/1
  # PATCH/PUT /payment_classifications/1.json
  def update
    respond_to do |format|
      if @payment_classification.update(payment_classification_params)
        format.html { redirect_to @payment_classification, notice: 'Payment classification was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_classification }
      else
        format.html { render :edit }
        format.json { render json: @payment_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_classifications/1
  # DELETE /payment_classifications/1.json
  def destroy
    @payment_classification.destroy
    respond_to do |format|
      format.html { redirect_to payment_classifications_url, notice: 'Payment classification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_classification
      @payment_classification = PaymentClassification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_classification_params
      params.require(:payment_classification).permit(:purpose, :name)
    end
end
