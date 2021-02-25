require 'rails_helper'

RSpec.describe LineChart::Item, type: :model do
  subject { LineChart::Item.new(label: "2021/02") }
  before do
    FactoryBot.create(:item, payed_on: Date.new(2021, 2, 25))
  end

  it "#to_json" do
    expect(subject.to_json).to eq({:label=>"2021/02", :border_color=>"#E39800", :data=>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], :fill=>false})
  end
end
