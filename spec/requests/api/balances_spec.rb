require 'rails_helper'

RSpec.describe "Api::Balances", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/balances/index"
      expect(response).to have_http_status(:success)
    end
  end

end
