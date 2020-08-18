require "rails_helper"

RSpec.describe "PaymentClassification", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  describe "新規登録" do
    before do
      visit new_payment_classification_path
      select "生活に必要", from: "目的"
      fill_in "名称", with: name
      fill_in "並び順", with: "2"
      click_button "保存"
    end

    context "正常時" do
      let(:name) { "居住費" }

      it { expect(page).to have_text("収支分類を作成しました") }
    end

    context "不正時" do
      let(:name) { "" }

      it { expect(page).to have_text("名称を入力してください") }
    end
  end

  describe "編集" do
    let(:payment_classification) { FactoryBot.create(:payment_classification) }

    before do
      visit edit_payment_classification_path(payment_classification)
      select "生活に必要", from: "目的"
      fill_in "名称", with: name
      fill_in "並び順", with: "2"
      click_button "保存"
    end

    context "正常時" do
      let(:name) { "居住費" }

      it { expect(page).to have_text("収支分類を更新しました") }
    end

    context "不正時" do
      let(:name) { "" }

      it { expect(page).to have_text("名称を入力してください") }
    end
  end

  describe "削除" do
    let!(:payment_classification) { FactoryBot.create(:payment_classification) }

    context "収支に利用されていない時" do
      before do
        visit payment_classifications_path
        click_link "削除"
      end

      it { expect(page).to have_text("収支分類を削除しました") }
    end

    context "収支に利用されている時" do
      before do
        FactoryBot.create(:payment, payment_classification: payment_classification, user: user)
        visit payment_classifications_path
        click_link "削除"
      end

      it { expect(page).to have_text("収支分類を削除できませんでした") }
    end
  end
end
