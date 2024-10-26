
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

  has_many :image_tags, dependent: :destroy
  accepts_nested_attributes_for :image_tags, allow_destroy: true

  
  private
    def window_description

    end
end
