class ImageCore < ApplicationRecord
  belongs_to :image_path

  validates_length_of :image_name, presence: true, minimum: 0, maximum: 100, allow_blank: false
  validates_length_of :image_description, minimum: 0, maximum: 500, allow_blank: true

  has_many :image_tags, dependent: :destroy

  scope :search_by_tags -> {  }

end
