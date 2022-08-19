class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true,
                      length: {maximum: Settings.micropost.content_max_length}
  validates :image, content_type: {in: Settings.micropost.image_type,
                                   message: :valid_format},
                    size: {less_than: Settings.micropost.image_size.megabytes,
                           message: :should_less_than}
  delegate :name, to: :user
  scope :recent_posts, ->{order(created_at: :desc)}

  def display_image
    image.variant resize_to_limit: Settings.micropost.resize_to_limit
  end
end
