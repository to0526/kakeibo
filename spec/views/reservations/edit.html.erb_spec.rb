require 'rails_helper'

RSpec.describe "reservations/edit", type: :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      day: 1,
      kind: 1,
      amount: 1,
      user: nil,
      payment_classification: nil,
      payment_method: nil,
      note: "MyText"
    ))
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(@reservation), "post" do

      assert_select "input[name=?]", "reservation[day]"

      assert_select "input[name=?]", "reservation[kind]"

      assert_select "input[name=?]", "reservation[amount]"

      assert_select "input[name=?]", "reservation[user_id]"

      assert_select "input[name=?]", "reservation[payment_classification_id]"

      assert_select "input[name=?]", "reservation[payment_method_id]"

      assert_select "textarea[name=?]", "reservation[note]"
    end
  end
end
