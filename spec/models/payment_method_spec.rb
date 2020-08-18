require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe "validation" do
    context "名前が未入力の時" do
      let(:payment_method) { FactoryBot.build(:payment_method, name: "") }

      it { expect(payment_method.valid?).to be false }
    end

    context "収支に使われている時" do
      let(:payment_method) { FactoryBot.create(:payment_method) }
      before { FactoryBot.create(:payment, payment_method: payment_method) }

      it { expect(payment_method.destroy).to be false }
    end
  end
end
