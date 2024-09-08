class Artist < ApplicationRecord
    has_many :lps, dependent: :destroy
    
    validates :name, presence: true
end
