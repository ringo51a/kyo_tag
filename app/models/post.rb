class Post < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :place, presence: true

  mount_uploader :post_image, ImageUploader

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

  def save_with_tags_and_place(tag_names:, place_id:, place_name:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      self.place = Place.find_or_initialize_by(place_id: place_id.strip)
      if self.place.new_record?
        self.place.name = place_name.strip
        self.place.save!
      end
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    tags.map(&:name).join(',')  # pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
  end
end
