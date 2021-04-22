require 'rails_helper'

RSpec.describe "Api::PaymentMethods", type: :request do
  describe "GET /index" do
    let!(:user) do
      FactoryBot.create(:user, email: "test@example.com", password: "password")
    end
    let!(:payment_method1) { FactoryBot.create(:payment_method, name: "現金") }
    let!(:payment_method2) { FactoryBot.create(:payment_method, name: "クレジットカード") }
    let!(:payment_method3) { FactoryBot.create(:payment_method, name: "iD") }
    before do
      post "/user_sessions", params: { email: "test@example.com", password: "password" }
    end

    it "returns http success" do
      get "/api/payment_methods"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([
        { "id" => payment_method1.id, "name" => "現金" },
        { "id" => payment_method2.id, "name" => "クレジットカード" },
        { "id" => payment_method3.id, "name" => "iD" },
      ])
    end
  end
end
