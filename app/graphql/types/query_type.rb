module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :datacollection, DatacollectionType, null: true do
      argument :labels, [String, null: true], required: true
    end

    def datacollection(labels:)
      {
        labels: (1..31).to_a,
        datasets: labels.map { |label| ::LineChart::Item.new(label: label).to_json },
      }
    end

    field :selectable_year_months, [String], null: true

    def selectable_year_months
      dates = (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
      dates.select { |d| d.day == 1 }.map { |d| d.strftime("%Y/%m") }
    end

    field :data, [DataType], null: true do
      argument :labels, [String, null: true], required: true
    end

    def data(labels:)
      labels.map { |label| ::LineChart::Table.new(label: label).to_json }
    end
  end
end
