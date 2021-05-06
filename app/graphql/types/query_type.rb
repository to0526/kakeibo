module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :datacollection, DatacollectionType, null: true do
      argument :labels, [String, null: true], required: true
      argument :user_ids, [Int, null: true], required: true
      argument :payment_classification_ids, [Int, null: true], required: true
      argument :payment_method_ids, [Int, null: true], required: true
    end

    def datacollection(labels:, user_ids:, payment_classification_ids:, payment_method_ids:)
      {
        labels: (1..31).to_a,
        datasets: labels.map do |label|
          ::LineChart::Item.new(
            label: label,
            user_ids: user_ids,
            payment_classification_ids: payment_classification_ids,
            payment_method_ids: payment_method_ids
          ).to_json
        end
      }
    end

    field :data, [DataType], null: true do
      argument :labels, [String, null: true], required: true
      argument :user_ids, [Int, null: true], required: true
      argument :payment_classification_ids, [Int, null: true], required: true
      argument :payment_method_ids, [Int, null: true], required: true
    end

    def data(labels:, user_ids:, payment_classification_ids:, payment_method_ids:)
      labels.map do |label|
        ::LineChart::Table.new(
          label: label,
          user_ids: user_ids,
          payment_classification_ids: payment_classification_ids,
          payment_method_ids: payment_method_ids
        ).to_json
      end
    end
  end
end
