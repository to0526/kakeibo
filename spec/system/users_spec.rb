require "rails_helper"

RSpec.describe "UserSession", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  describe "新規登録" do
    before do
      visit new_user_path
      fill_in "名前", with: name
      fill_in "メールアドレス", with: "taro@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード(確認)", with: "password"
      click_button "保存"
    end

    context "正常時" do
      let(:name) { "テスト太郎" }

      it { expect(page).to have_text("ユーザーを作成しました") }
    end

    context "不正時" do
      let(:name) { "" }

      it { expect(page).to have_text("名前を入力してください") }
    end
  end

  describe "編集" do
    before do
      visit edit_user_path(user)
      fill_in "名前", with: name
      fill_in "メールアドレス", with: "taro@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード(確認)", with: "password"
      click_button "保存"
    end

    context "正常時" do
      let(:name) { "テスト太郎" }

      it { expect(page).to have_text("ユーザーを更新しました") }
    end

    context "不正時" do
      let(:name) { "" }

      it { expect(page).to have_text("名前を入力してください") }
    end
  end

  describe "削除" do
    let!(:user2) { FactoryBot.create(:user, email: "test2@example.com") }

    context "収支を登録していない時" do
      before do
        visit users_path
        click_link "削除", href: "/users/#{user2.id}"
      end

      it { expect(page).to have_text("ユーザーを削除しました") }
    end

    context "収支を登録している時" do
      before do
        FactoryBot.create(:payment, user: user2)
        visit users_path
        click_link "削除", href: "/users/#{user2.id}"
      end

      it { expect(page).to have_text("ユーザーを削除できませんでした") }
    end
  end
end
