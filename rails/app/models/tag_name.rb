class TagName < ApplicationRecord
  validates_uniqueness_of :name, presence: true
  validates_length_of :name, minimum: 0, maximum: 20, allow_blank: false
  has_many :image_tags, dependent: :destroy
end