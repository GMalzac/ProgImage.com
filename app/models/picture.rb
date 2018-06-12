class Picture < ApplicationRecord
  belongs_to :user

  validates :format, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :url, presence: true

end
