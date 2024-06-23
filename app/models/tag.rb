class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  
  validates :name, presence: true, uniqueness: true

  scope :with_posts, -> { joins(:taggings).distinct }
end