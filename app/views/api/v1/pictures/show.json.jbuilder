json.extract! @picture, :id, :format, :created_at, :width, :height, :url, :user_id, :updated_at, :image_url
json.user_email @picture.user.email
