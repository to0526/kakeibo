module Types
  class DatacollectionType < Types::BaseObject
    field :labels, [String], null: false
    field :datasets, [Types::DatasetType], null: false
  end
end
