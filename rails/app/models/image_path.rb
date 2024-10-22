class ImagePath < ApplicationRecord
  validates_uniqueness_of :image_path
  validates_length_of :image_path, minimum: 0, maximum: 300, allow_blank: false
  has_many :image_cores, dependent: :destroy
  has_many :image_tags, through: :image_cores
end
