require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "datacollection" do
    subject { KakeiboSchema.execute(query_string, variables: variables) }
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
      expect(datacollection["labels"]).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"])
      expect(dataset["label"]).to eq("2020/01")
      expect(dataset["borderColor"]).to eq("#E60012")
      expect(dataset["data"]).to eq(["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"])
      expect(dataset["fill"]).to eq(false)
    end
  end
end
