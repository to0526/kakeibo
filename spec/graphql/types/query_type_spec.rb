require 'rails_helper'

RSpec.describe Types::QueryType do
  subject { KakeiboSchema.execute(query_string, variables: variables) }
  let(:user) { FactoryBot.create(:user) }
  let(:payment_classification) { FactoryBot.create(:payment_classification) }
  let(:payment_method) { FactoryBot.create(:payment_method) }
  before do
    FactoryBot.create(
      :item,
      payed_on: Date.new(2021, 1, 1),
      user: user,
      payment_classification: payment_classification,
      payment_method: payment_method
    )
  end

  describe "#datacollection" do
    let(:query_string) do
      <<~STR
      query datacollection($labels: [String]!, $userIds: [Int]!, $paymentClassificationIds: [Int]!, $paymentMethodIds: [Int]!) {
        datacollection(labels: $labels, userIds: $userIds, paymentClassificationIds: $paymentClassificationIds, paymentMethodIds: $paymentMethodIds) {
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
      {
        labels: ["2020/01"],
        userIds: [user.id],
        paymentClassificationIds: [payment_classification.id],
        paymentMethodIds: [payment_method.id]
      }
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

  describe "#data" do
    let(:query_string) do
      <<~STR
      query data($labels: [String]!, $userIds: [Int]!, $paymentClassificationIds: [Int]!, $paymentMethodIds: [Int]!) {
        data(labels: $labels, userIds: $userIds, paymentClassificationIds: $paymentClassificationIds, paymentMethodIds: $paymentMethodIds) {
          yearMonth
          income
          payment
          total
        }
      }
      STR
    end
    let(:variables) do
      {
        labels: ["2020/01"],
        userIds: [user.id],
        paymentClassificationIds: [payment_classification.id],
        paymentMethodIds: [payment_method.id]
      }
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
