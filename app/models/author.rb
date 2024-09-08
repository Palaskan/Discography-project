class Author < ApplicationRecord
    has_and_belongs_to_many :songs, dependent: :destroy
    
    validates :name, presence: true
end
