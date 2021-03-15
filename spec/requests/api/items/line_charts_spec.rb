require 'rails_helper'

RSpec.describe "Api::Items::LineCharts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/items/line_charts/index"
      expect(response).to have_http_status(:success)
    end
  end

end
