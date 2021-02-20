module Types
  class DatasetType < Types::BaseObject
    field :border_color, String, null: false
    field :label, String, null: false
    field :data, [String], null: false
    field :fill, Boolean, null: false
  end
end
