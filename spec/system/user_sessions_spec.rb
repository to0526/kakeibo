require "rails_helper"

RSpec.describe "UserSession", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  describe "ログイン" do
    before do
      visit login_path
      fill_in "メールアドレス", with: email
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context "正しくログイン情報を入力した時" do
      let(:email) { "test@example.com" }

      it { expect(page).to have_text("ログインに成功しました") }
    end

    context "ログイン情報が不正の時" do
      let(:email) { "" }

      it { expect(page).to have_text("ログインに失敗しました") }
    end
  end

  describe "ログアウト" do
    before do
      visit login_path
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context "ログアウトリンクをクリックした時" do
      before { click_link "ログアウト" }

      it { expect(page).to have_text("ログアウトしました") }
    end
  end
end
