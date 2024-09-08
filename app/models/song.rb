class Song < ApplicationRecord
    has_and_belongs_to_many :authors, dependent: :destroy
    belongs_to :lp
    
    validates :name, presence: true
end
