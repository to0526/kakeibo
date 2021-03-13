require 'rails_helper'

RSpec.describe Types::QueryType do
  subject { KakeiboSchema.execute(query_string) }

  describe "#test_field" do
    let(:query_string) do
      <<~STR
      mutation {
        testField
      }
      STR
    end

    it do
      expect(subject["data"]["testField"]).to eq("Hello World")
    end
  end
end
