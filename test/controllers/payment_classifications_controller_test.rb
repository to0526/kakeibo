require 'test_helper'

class PaymentClassificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment_classification = payment_classifications(:one)
  end

  test "should get index" do
    get payment_classifications_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_classification_url
    assert_response :success
  end

  test "should create payment_classification" do
    assert_difference('PaymentClassification.count') do
      post payment_classifications_url, params: { payment_classification: { name: @payment_classification.name, purpose: @payment_classification.purpose } }
    end

    assert_redirected_to payment_classification_url(PaymentClassification.last)
  end

  test "should show payment_classification" do
    get payment_classification_url(@payment_classification)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_classification_url(@payment_classification)
    assert_response :success
  end

  test "should update payment_classification" do
    patch payment_classification_url(@payment_classification), params: { payment_classification: { name: @payment_classification.name, purpose: @payment_classification.purpose } }
    assert_redirected_to payment_classification_url(@payment_classification)
  end

  test "should destroy payment_classification" do
    assert_difference('PaymentClassification.count', -1) do
      delete payment_classification_url(@payment_classification)
    end

    assert_redirected_to payment_classifications_url
  end
end
