class Embedding < ApplicationRecord
  validates_length_of :embedding, maximum: 384, allow_blank: false
end
