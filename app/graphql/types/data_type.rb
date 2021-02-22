module Types
  class DataType < Types::BaseObject
    field :year_month, String, null: false
    field :income, String, null: false
    field :payment, String, null: false
    field :total, String, null: false
  end
end
