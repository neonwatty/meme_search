require 'informers'

class ImageCore < ApplicationRecord  
  include PgSearch::Model

  pg_search_scope :search_any_word,
                  against: [:description],
                  using: {
                    tsearch: { any_word: true }
                  }

  scope :with_selected_tag_names, ->(selected_tag_names) {
    joins(image_tags: :tag_name)
      .where(tag_names: { name: selected_tag_names })
      .distinct
      .order(created_at: :desc) 
  }

  belongs_to :image_path

  validates_length_of :name, presence: true, minimum: 0, maximum: 100, allow_blank: false
  validates_length_of :description, minimum: 0, maximum: 500, allow_blank: true
  # validates :status, presence: true

  has_many :image_tags, dependent: :destroy
  accepts_nested_attributes_for :image_tags, allow_destroy: true

  before_save :refresh_description_embeddings

  def refresh_description_embeddings
    # destroy current description embeddings 
    begin
      current_embeddings = ImageEmbedding.where({image_core_id: self.id})
      current_embeddings.map {|item| item.destroy!}
      current_embeddings = ImageEmbedding.where({image_core_id: self.id})
    rescue StandardError => e
      puts "THE DESTROY EXCEPTION --> #{e}"
    end
    if !self.description.nil?
      if self.description.length > 0
        snippets = chunk_text(self.description)
        snippets_hash = snippets.map.with_index {|snippet, index| {image_core_id: self.id, snippet: snippet}}
        snippets_hash.map {|hash| ImageEmbedding.new(hash).save! } 
      end
    end
  end

  private

    def clean_word(text)
      # clean input text - keeping only lower case letters, numbers, punctuation, and single quote symbols
      cleaned_text = text.downcase.strip.gsub(/[^a-z0-9,.!?']/, ' ')
      cleaned_text.gsub!(/\s+/, ' ')
      cleaned_text
    end

    def chunk_text(text)
      # split and clean input text
      text_split = clean_word(text).split(" ")
      text_split.reject!(&:empty?)

      # use two pointers to create chunks
      chunk_size = 4
      overlap_size = 2

      # create next chunk by moving right pointer until chunk_size is reached or line_number changes by more than 1 or end of word_sequence is reached
      left_pointer = 0
      right_pointer = chunk_size - 1
      chunks = []

      if right_pointer >= text_split.length
        chunks << text_split.join(" ")
      else
        while right_pointer < text_split.length
          # create chunk
          chunk = text_split[left_pointer..right_pointer]

          # move left pointer
          left_pointer += chunk_size - overlap_size

          # move right pointer
          right_pointer += chunk_size - overlap_size

          # store chunk
          chunks << chunk.join(" ")
        end

        # check if there is final chunk
        if left_pointer < text_split.length
          last_chunk = text_split[left_pointer..-1]
          chunks << last_chunk.join(" ")
        end
      end

      # insert the full text
      if chunks.length > 1
        chunks.insert(0, text.downcase)
      end

      chunks
    end

end
