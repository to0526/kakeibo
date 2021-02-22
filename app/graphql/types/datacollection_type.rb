module Types
  class DatacollectionType < Types::BaseObject
    field :labels, [String], null: false
    field :datasets, [Types::DatasetType], null: false
    field :data, [Types::DataType], null: false
  end
end
