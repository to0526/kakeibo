require 'rails_helper'

RSpec.describe "reservations/index", type: :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        day: 2,
        kind: 3,
        amount: 4,
        user: nil,
        payment_classification: nil,
        payment_method: nil,
        note: "MyText"
      ),
      Reservation.create!(
        day: 2,
        kind: 3,
        amount: 4,
        user: nil,
        payment_classification: nil,
        payment_method: nil,
        note: "MyText"
      )
    ])
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
