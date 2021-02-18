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

    field :datacollection, DatacollectionType, null: true

    def datacollection
      {
        labels: (1..31).to_a,
        datasets: [
          {
            background_color: "#E60012",
            label: "2021/01",
            data: [
              "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
              "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
              "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
              "0"
            ],
            fill: false
          },
          {
            background_color: "#E39800",
            label: "2021/02",
            data: [
              "0", "-123", "-123", "-123", "-123", "-123", "-123", "-123", "-123", "-123",
              "-246", "-369", "-369", "-369", "-369", "19631", "19631", "19631", "19631", "19631",
              "19631", "19631", "19631", "19631", "19508", "19508", "19508", "19508"
            ],
            fill: false
          }
        ]
      }
    end
  end
end
