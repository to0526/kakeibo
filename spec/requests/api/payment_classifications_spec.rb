require 'rails_helper'

RSpec.describe "Api::PaymentClassifications", type: :request do
  describe "GET /index" do
    let!(:user) do
      FactoryBot.create(:user, email: "test@example.com", password: "password")
    end
    let!(:payment_classification1) do
      FactoryBot.create(:payment_classification, name: "食費", sort: 1)
    end
    let!(:payment_classification2) do
      FactoryBot.create(:payment_classification, name: "居住費", sort: 2)
    end
    let!(:payment_classification3) do
      FactoryBot.create(:payment_classification, name: "水道光熱費", sort: 3)
    end

    before do
      post "/user_sessions", params: { email: "test@example.com", password: "password" }
    end

    it "returns http success" do
      get "/api/payment_classifications"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([
        { "id" => payment_classification1.id, "name" => "食費" },
        { "id" => payment_classification2.id, "name" => "居住費" },
        { "id" => payment_classification3.id, "name" => "水道光熱費" },
      ])
    end
  end
end
