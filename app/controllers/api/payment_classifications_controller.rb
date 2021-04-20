class Api::PaymentClassificationsController < ApplicationController
  def index
    @payment_classifications = PaymentClassification.all
  end
end
