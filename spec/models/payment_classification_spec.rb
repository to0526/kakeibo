require 'rails_helper'

RSpec.describe PaymentClassification, type: :model do
  describe "validation" do
    context "名前が未入力の時" do
      let(:payment_classification) { FactoryBot.build(:payment_classification, name: "") }

      it { expect(payment_classification.valid?).to be false }
    end

    context "並び順が未入力の時" do
      let(:payment_classification) { FactoryBot.build(:payment_classification, sort: nil) }

      it { expect(payment_classification.valid?).to be false }
    end

    context "収支に使われている時" do
      let(:payment_classification) { FactoryBot.create(:payment_classification) }
      before { FactoryBot.create(:payment, payment_classification: payment_classification) }

      it { expect(payment_classification.destroy).to be false }
    end
  end
end
