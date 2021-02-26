require "rails_helper"

RSpec.describe "Income", type: :system do
  let!(:user) { FactoryBot.create(:user, email: "test@example.com") }
  let!(:income) { FactoryBot.create(:income, user: user) }

  before do
    visit login_path
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  describe "新規登録" do
    before do
      visit new_income_path
      fill_in "支払日", with: payed_on
      fill_in "支払金額", with: "10000"
      select "食費", from: "支払分類"
      select "現金", from: "支払方法"
      click_button "保存"
    end

    context "正常時" do
      let(:payed_on) { "2020/08/17" }

      it { expect(page).to have_text("収入を登録しました") }
    end

    context "不正時" do
      let(:payed_on) { "" }

      it { expect(page).to have_text("支払日を入力してください") }
    end
  end

  describe "編集" do
    before do
      visit edit_income_path(income)
      fill_in "支払日", with: payed_on
      fill_in "支払金額", with: "10000"
      select "食費", from: "支払分類"
      select "現金", from: "支払方法"
      click_button "保存"
    end

    context "正常時" do
      let(:payed_on) { "2020/08/17" }

      it { expect(page).to have_text("収入を更新しました") }
    end

    context "不正時" do
      let(:payed_on) { "" }

      it { expect(page).to have_text("支払日を入力してください") }
    end
  end

  describe "削除" do
    before do
      visit items_path
      click_link "削除"
    end

    it { expect(page).to have_text("収入を削除しました") }
  end
end
