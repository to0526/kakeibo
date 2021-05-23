require 'rails_helper'

RSpec.describe "Api::Items::Balances", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/items/balances/index"
      expect(response).to have_http_status(:success)
    end
  end

end
