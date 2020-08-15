class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.name_with_id
    all.map { |u| [ u.name, u.id ] }
  end
end
