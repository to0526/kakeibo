require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "GET /index" do
    let!(:user1) do
      FactoryBot.create(:user,
                        name: "テスト太郎",
                        email: "test@example.com",
                        password: "password")
    end
    let!(:user2) { FactoryBot.create(:user, name: "テスト次郎") }
    let!(:user3) { FactoryBot.create(:user, name: "テスト三郎") }

    before do
      post "/user_sessions", params: { email: "test@example.com", password: "password" }
    end

    it "returns http success" do
      get "/api/users"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([
        { "id" => user1.id, "name" => "テスト太郎" },
        { "id" => user2.id, "name" => "テスト次郎" },
        { "id" => user3.id, "name" => "テスト三郎" }
      ])
    end
  end
end
