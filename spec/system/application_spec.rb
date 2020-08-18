require "rails_helper"

RSpec.describe "UserSession", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  context "ログインせず収支一覧にアクセスした時" do
    before { visit items_path }

    it { expect(page).to have_text("ログインしてください") }
  end
end
