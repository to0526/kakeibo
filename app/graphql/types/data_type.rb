module Types
  class DataType < Types::BaseObject
    field :income, Int, null: false
    field :payment, Int, null: false
    field :total, Int, null: false
  end
end
