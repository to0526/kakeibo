require "rails_helper"

RSpec.describe "PaymentMethods", type: :system do
  let!(:user) { FactoryBot.create(:user, email: "test@example.com") }

  before do
    visit login_path
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  describe "新規登録" do
    before do
      visit new_payment_method_path
      fill_in "名称", with: name
      click_button "保存"
    end

    context "正常時" do
      let(:name) { "現金" }

      it { expect(page).to have_text("収支方法を作成しました") }
    end

    context "不正時" do
      let(:name) { "" }

      it { expect(page).to have_text("名称を入力してください") }
    end
  end

  describe "編集" do
    let(:payment_method) { FactoryBot.create(:payment_method) }

    before do
      visit edit_payment_method_path(payment_method)
      fill_in "名称", with: name
      click_button "保存"
    end

    context "正常時" do
      let(:name) { "クレジットカード" }

      it { expect(page).to have_text("収支方法を更新しました") }
    end

    context "不正時" do
      let(:name) { "" }

      it { expect(page).to have_text("名称を入力してください") }
    end
  end

  describe "削除" do
    let!(:payment_method) { FactoryBot.create(:payment_method) }

    context "収支に利用されていない時" do
      before do
        visit payment_methods_path
        click_link "削除"
      end

      it { expect(page).to have_text("収支方法を削除しました") }
    end

    context "収支に利用されている時" do
      before do
        FactoryBot.create(:payment, payment_method: payment_method, user: user)
        visit payment_methods_path
        click_link "削除"
      end

      it { expect(page).to have_text("収支方法を削除できませんでした") }
    end
  end
end
