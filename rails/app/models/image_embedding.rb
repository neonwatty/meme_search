require 'informers'

class ImageEmbedding < ApplicationRecord
  validates :snippet, presence: true
  validates_length_of :embedding, maximum: 384, allow_blank: true
  has_neighbors :embedding
  before_save :compute_embedding, if: -> { embedding.nil? }

  attr_accessor :model

  def initialize(attributes = {})
    super
    @model = Informers.pipeline("embedding", "sentence-transformers/all-MiniLM-L6-v2")
  end

  def get_neighbors
    nearest_neighbors(:embedding, distance: "cosine").first(10)
  end
  
  def compute_embedding
    self.embedding = model.(self.snippet)
  end
end
