require 'rails_helper'

RSpec.describe Income, type: :model do
  describe "validation" do
    context "金額が未入力の時" do
      let(:income) { FactoryBot.build(:income, amount: nil) }

      it { expect(income.valid?).to be false }
    end

    context "日時が未入力の時" do
      let(:income) { FactoryBot.build(:income, payed_on: nil) }

      it { expect(income.valid?).to be false }
    end
  end
end
