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

    field :selectable_year_months, [String], null: true

    def selectable_year_months
      dates = (Date.new(2020,07,01)..Date.today.beginning_of_month).to_a
      dates.select { |d| d.day == 1 }.map { |d| d.strftime("%Y/%m") }
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

    field :payment_classifications, [PaymentClassificationType], null: true

    def payment_classifications
      PaymentClassification.all
    end

    field :payment_methods, [PaymentMethodType], null: true

    def payment_methods
      PaymentMethod.all
    end
  end
end
