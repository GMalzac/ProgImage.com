class Picture < ApplicationRecord

  belongs_to :user

  validates :format, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :source, presence: true

  has_one_attached :image

  def thumbnail
    return self.image.variant(resize: '300x300')
  end

end
