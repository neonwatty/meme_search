class TagName < ApplicationRecord
  validate :name, presence: true
  validates_uniqueness_of :name
  validates_length_of :name, minimum: 0, maximum: 20, allow_blank: false
end
