require 'rails_helper'

RSpec.describe Types::QueryType do
  subject { KakeiboSchema.execute(query_string, variables: variables) }

  describe "#datacollection" do
    before { FactoryBot.create(:item, payed_on: Date.new(2021, 1, 1)) }
    let(:query_string) do
      <<~STR
      query datacollection($labels: [String]!) {
        datacollection(labels: $labels) {
          labels
          datasets {
            label
            borderColor
            data
            fill
          }
        }
      }
      STR
    end
    let(:variables) do
      { labels: ["2020/01"] }
    end
    let(:datacollection) { subject["data"]["datacollection"] }
    let(:dataset) { datacollection["datasets"][0] }

    it do
      expect(datacollection["labels"]).to eq([
        "1", "2", "3", "4", "5",
        "6", "7", "8", "9", "10",
        "11", "12", "13", "14", "15",
        "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25",
        "26", "27", "28", "29", "30", "31"
      ])
      expect(dataset["label"]).to eq("2020/01")
      expect(dataset["borderColor"]).to eq("#E60012")
      expect(dataset["data"]).to eq([
        "0", "0", "0", "0", "0",
        "0", "0", "0", "0", "0",
        "0", "0", "0", "0", "0",
        "0", "0", "0", "0", "0",
        "0", "0", "0", "0", "0",
        "0", "0", "0", "0", "0", "0"
      ])
      expect(dataset["fill"]).to eq(false)
    end
  end

  describe "#selectable_year_months" do
    let(:query_string) do
      <<~STR
      query selectableYearMonths {
        selectableYearMonths
      }
      STR
    end
    let(:variables) do
      { }
    end

    it do
      travel_to Time.zone.parse("2021-02-26") do
        expect(subject["data"]["selectableYearMonths"]).to eq([
          "2020/07",
          "2020/08",
          "2020/09",
          "2020/10",
          "2020/11",
          "2020/12",
          "2021/01",
          "2021/02"
        ])
      end
    end
  end

  describe "#data" do
    before { FactoryBot.create(:item, payed_on: Date.new(2021, 1, 1)) }
    let(:query_string) do
      <<~STR
      query data($labels: [String]!) {
        data(labels: $labels) {
          yearMonth
          income
          payment
          total
        }
      }
      STR
    end
    let(:variables) do
      { labels: ["2020/01"] }
    end

    it do
      expect(subject["data"]["data"][0]).to eq({
        "yearMonth"=>"2020/01",
        "income"=>"0",
        "payment"=>"0",
        "total"=>"0"
      })
    end
  end
end
