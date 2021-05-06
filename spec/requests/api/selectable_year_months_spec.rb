require 'rails_helper'

RSpec.describe "Api::SelectableYearMonths", type: :request do
  describe "GET /index" do
    let!(:user) do
      FactoryBot.create(:user, email: "test@example.com", password: "password")
    end
    before do
      post "/user_sessions", params: { email: "test@example.com", password: "password" }
    end

    it "returns http success" do
      travel_to Date.new(2020, 9, 1) do
        get "/api/selectable_year_months"
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq(["2020/07", "2020/08", "2020/09"])
      end
    end
  end
end
