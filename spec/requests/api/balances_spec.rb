require 'rails_helper'

RSpec.describe "Api::Balances", type: :request do
  describe "GET /index" do
    let!(:user) do
      FactoryBot.create(:user, email: "test@example.com", password: "password")
    end

    before do
      post "/user_sessions", params: { email: "test@example.com", password: "password" }
    end

    it "returns http success" do
      get "/api/balances?year_months[]=2021/04&year_months[]=2021/05"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([
        {"year_month"=>"2021/04", "payment"=>0, "income"=>0, "balance"=>0},
        {"year_month"=>"2021/05", "payment"=>0, "income"=>0, "balance"=>0}
      ])
    end
  end
end
