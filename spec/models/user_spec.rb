require 'rails_helper'

RSpec.describe User, type: :model do
  describe ".name_with_id" do
    let!(:user1) { FactoryBot.create(:user, name: "大悟", email: "daigo@example.com") }
    let!(:user2) { FactoryBot.create(:user, name: "ノブ", email: "nobu@example.com") }

    it { expect(User.name_with_id).to match_array([["大悟", user1.id], ["ノブ", user2.id]]) }
  end

  describe "validation" do
    context "名前が未入力の時" do
      let(:user) { FactoryBot.build(:user, name: "") }

      it { expect(user.valid?).to be false }
    end

    context "メールアドレスが未入力の時" do
      let(:user) { FactoryBot.build(:user, email: "") }

      it { expect(user.valid?).to be false }
    end

    context "メールアドレスが重複している時" do
      before { FactoryBot.create(:user, email: "test@example.com") }
      let(:user) { FactoryBot.build(:user, email: "test@example.com") }

      it { expect(user.valid?).to be false }
    end

    context "パスワードが未入力の時(新規登録時)" do
      let(:user) { FactoryBot.build(:user, password: "") }

      it { expect(user.valid?).to be false }
    end

    context "パスワード(確認)が未入力の時(新規登録時)" do
      let(:user) { FactoryBot.build(:user, password_confirmation: "") }

      it { expect(user.valid?).to be false }
    end

    context "パスワードが2文字の時(新規登録時)" do
      let(:user) { FactoryBot.build(:user, password: "ab", password_confirmation: "ab") }

      it { expect(user.valid?).to be false }
    end

    context "パスワードが3文字の時(新規登録時)" do
      let(:user) { FactoryBot.build(:user, password: "abc", password_confirmation: "abc") }

      it { expect(user.valid?).to be true }
    end

    context "パスワード(更新時)" do
      let(:user) { FactoryBot.create(:user) }

      context "パスワードが2文字の時(更新時)" do
        before do
          user.password = "ab"
          user.password_confirmation = "ab"
        end

        it { expect(user.valid?).to be false }
      end

      context "パスワードが3文字の時(更新時)" do
        before do
          user.password = "abc"
          user.password_confirmation = "abc"
        end

        it { expect(user.valid?).to be true }
      end
    end

    context "収支を登録している時" do
      let(:user) { FactoryBot.create(:user) }
      before { FactoryBot.create(:payment, user: user) }

      it { expect(user.destroy).to be false }
    end
  end
end
