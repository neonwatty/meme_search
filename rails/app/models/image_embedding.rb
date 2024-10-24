require 'informers'

class ImageEmbedding < ApplicationRecord
  attr_accessor :model

  def initialize(attributes = {})
    super
    @model = Informers.pipeline("embedding", "sentence-transformers/all-MiniLM-L6-v2")
  end

  validates_length_of :embedding, maximum: 384, allow_blank: false
  has_neighbors :embedding

  private
    def get_neighbors
      self.nearest_neighbors(:embedding, distance: "cosine").first(10)
    end
    
    def compute_embedding(snippet)
      snippet_embedding = model.(snippet)
    end
end
