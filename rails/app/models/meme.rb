class Meme < ApplicationRecord
  validates :filename, presence: true
  validates_uniqueness_of :filename
  validates_length_of :filename, minimum: 0, maximum: 100, allow_blank: false
  validates_length_of :description, minimum: 0, maximum: 500, allow_blank: true

  has_one_attached :image
end
