require 'rails_helper'

RSpec.describe LineChart::Table, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:line_chart_table) { LineChart::Table.new(label: "2021/02", user_ids: [user.id]) }
  before do
    FactoryBot.create(:income, payed_on: Date.new(2021, 2, 1), amount: 100_000, user: user)
    FactoryBot.create(:payment, payed_on: Date.new(2021, 2, 1), amount: -10_000, user: user)
  end

  describe "#to_json" do
    subject { line_chart_table.to_json }

    it do
      is_expected.to eq({
        :year_month=>"2021/02",
        :income=>"100,000",
        :payment=>"-10,000",
        :total=>"90,000"
      })
    end
  end
end
