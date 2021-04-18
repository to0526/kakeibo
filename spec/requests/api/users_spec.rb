require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  xdescribe "GET /index" do
    it "returns http success" do
      get "/api/users/index"
      expect(response).to have_http_status(:success)
    end
  end
end
