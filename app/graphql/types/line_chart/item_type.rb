module Types
  module LineChart
    class ItemType < Types::BaseObject
      field :label, String, null: true
      field :background_color, String, null: true
      field :data, [String], null: true
      field :fill, Boolean, null: true
    end
  end
end
