module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :line_chart_items, [LineChart::ItemType], null: true do
      argument :labels, [String], required: true
    end

    def line_chart_items(labels:)
      labels.map do |label|
        ::LineChart::Item.new(label: label).to_json
      end
    end
  end
end
