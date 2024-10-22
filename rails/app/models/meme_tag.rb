class MemeTag < ApplicationRecord
    validates_length_of :description, minimum: 0, maximum: 300, allow_blank: true

end
