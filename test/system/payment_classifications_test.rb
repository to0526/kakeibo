require "application_system_test_case"

class PaymentClassificationsTest < ApplicationSystemTestCase
  setup do
    @payment_classification = payment_classifications(:one)
  end

  test "visiting the index" do
    visit payment_classifications_url
    assert_selector "h1", text: "Payment Classifications"
  end

  test "creating a Payment classification" do
    visit payment_classifications_url
    click_on "New Payment Classification"

    fill_in "Name", with: @payment_classification.name
    fill_in "Purpose", with: @payment_classification.purpose
    click_on "Create Payment classification"

    assert_text "Payment classification was successfully created"
    click_on "Back"
  end

  test "updating a Payment classification" do
    visit payment_classifications_url
    click_on "Edit", match: :first

    fill_in "Name", with: @payment_classification.name
    fill_in "Purpose", with: @payment_classification.purpose
    click_on "Update Payment classification"

    assert_text "Payment classification was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment classification" do
    visit payment_classifications_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment classification was successfully destroyed"
  end
end
