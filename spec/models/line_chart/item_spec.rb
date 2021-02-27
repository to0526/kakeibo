require 'rails_helper'

RSpec.describe LineChart::Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:line_chart_item) { LineChart::Item.new(label: label, user_ids: [user.id]) }

  before do
    (1..12).to_a do |month|
      FactoryBot.create(:item, payed_on: Date.new(2021, month, 1), user: user)
    end
  end

  describe "#to_json" do
    subject { line_chart_item.to_json }
    let(:label) { "2021/02" }

    it do
      is_expected.to eq({
        :label=>"2021/02",
        :border_color=>"#E39800",
        :data=>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        :fill=>false
      })
    end
  end

  describe "#border_color" do
    subject { line_chart_item.border_color }

    context "1月のとき" do
      let(:label) { "2021/01" }
      it { is_expected.to eq("#E60012") }
    end

    context "2月のとき" do
      let(:label) { "2021/02" }
      it { is_expected.to eq("#E39800") }
    end

    context "3月のとき" do
      let(:label) { "2021/03" }
      it { is_expected.to eq("#FFF100") }
    end

    context "4月のとき" do
      let(:label) { "2021/04" }
      it { is_expected.to eq("#8FC31F") }
    end

    context "5月のとき" do
      let(:label) { "2021/05" }
      it { is_expected.to eq("#009944") }
    end

    context "6月のとき" do
      let(:label) { "2021/06" }
      it { is_expected.to eq("#009E96") }
    end

    context "7月のとき" do
      let(:label) { "2021/07" }
      it { is_expected.to eq("#00A0E9") }
    end

    context "8月のとき" do
      let(:label) { "2021/08" }
      it { is_expected.to eq("#0068B7") }
    end

    context "9月のとき" do
      let(:label) { "2021/09" }
      it { is_expected.to eq("#1D2088") }
    end

    context "10月のとき" do
      let(:label) { "2021/10" }
      it { is_expected.to eq("#920783") }
    end

    context "11月のとき" do
      let(:label) { "2021/11" }
      it { is_expected.to eq("#E4007F") }
    end

    context "12月のとき" do
      let(:label) { "2021/12" }
      it { is_expected.to eq("#E5004F") }
    end
  end
end
