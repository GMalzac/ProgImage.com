class Picture < ApplicationRecord
  validate :image_format
  belongs_to :user

  validates :format, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :url, presence: true

  has_one_attached :image

  def image_from_url(url)
    self.image = open(url)
  end

  def image_format
    return unless image.attached?
    return if image.blob.content_type.start_with? 'image/'
    image.purge_later
    errors.add(:image, 'needs to be an image')
  end
end
