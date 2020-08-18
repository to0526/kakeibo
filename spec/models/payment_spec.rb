require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "#make_negative_amount" do
    context "保存時金額が正の値の時" do
      let(:payment) { FactoryBot.build(:payment, amount: 1) }
      before { payment.save }

      it { expect(payment.amount).to eq -1 }
    end

    context "保存時金額が負の値の時" do
      let(:payment) { FactoryBot.build(:payment, amount: -1) }
      before { payment.save }

      it { expect(payment.amount).to eq -1 }
    end
  end
end
