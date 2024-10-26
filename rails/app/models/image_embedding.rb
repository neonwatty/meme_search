require 'informers'

class ImageEmbedding < ApplicationRecord
  validates_length_of :embedding, maximum: 384, allow_blank: false
  has_neighbors :embedding

  def get_neighbors
    nearest_neighbors(:embedding, distance: "cosine").first(10)
  end
  
  def compute_embedding(snippet)
    model =  Informers.pipeline("embedding", "sentence-transformers/all-MiniLM-L6-v2")
    self.embedding = model.(snippet)
  end
end
