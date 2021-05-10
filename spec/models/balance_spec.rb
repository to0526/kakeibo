require 'rails_helper'

RSpec.describe Balance, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:payment_classification1) { FactoryBot.create(:payment_classification, name: "食費", sort: 1) }
  let(:payment_classification2) { FactoryBot.create(:payment_classification, name: "娯楽費", sort: 2) }
  let(:payment_classification3) { FactoryBot.create(:payment_classification, name: "給料", sort: 3) }
  let(:payment_method1) { FactoryBot.create(:payment_method, name: "現金") }
  let(:payment_method2) { FactoryBot.create(:payment_method, name: "カード") }
  let(:payment_method3) { FactoryBot.create(:payment_method, name: "振り込み") }

  before do
    FactoryBot.create(:payment,
                      payed_on: Date.new(2021,05,01),
                      amount: -10_000,
                      user: user1,
                      payment_classification: payment_classification1,
                      payment_method: payment_method1)
    FactoryBot.create(:payment,
                      payed_on: Date.new(2021,05,31),
                      amount: -10_000,
                      user: user2,
                      payment_classification: payment_classification2,
                      payment_method: payment_method2)
    FactoryBot.create(:payment,
                      payed_on: Date.new(2021,06,01),
                      amount: -10_000,
                      user: user1,
                      payment_classification: payment_classification1,
                      payment_method: payment_method1)
    FactoryBot.create(:income,
                      payed_on: Date.new(2021,05,11),
                      amount: 100_000,
                      user: user1,
                      payment_classification: payment_classification3,
                      payment_method: payment_method3)
  end

  describe "#to_json" do
    subject { balance.to_json }

    context "5月を指定したとき" do
      let(:balance) { Balance.new(year_month: "2021/05") }

      it do
        is_expected.to eq({
          year_month: "2021/05",
          payment: -20000,
          income: 100000,
          balance: 80000
        })
      end
    end

    context "6月を指定したとき" do
      let(:balance) { Balance.new(year_month: "2021/06") }

      it do
        is_expected.to eq({
          year_month: "2021/06",
          payment: -10000,
          income: 0,
          balance: -10000
        })
      end
    end

    context "ユーザを指定したとき" do
      let(:balance) { Balance.new(year_month: "2021/05", user_ids: [user1.id]) }

      it do
        is_expected.to eq({
          year_month: "2021/05",
          payment: -10000,
          income: 100000,
          balance: 90000
        })
      end
    end

    context "支払い分類を指定したとき" do
      let(:balance) { Balance.new(year_month: "2021/05",
                                  payment_classification_ids: [payment_classification1.id, payment_classification2.id]) }

      it do
        is_expected.to eq({
          year_month: "2021/05",
          payment: -20000,
          income: 0,
          balance: -20000
        })
      end
    end

    context "支払い方法を指定したとき" do
      let(:balance) { Balance.new(year_month: "2021/05",
                                  payment_method_ids: [payment_method1.id, payment_method2.id]) }

      it do
        is_expected.to eq({
          year_month: "2021/05",
          payment: -20000,
          income: 0,
          balance: -20000
        })
      end
    end
  end
end
