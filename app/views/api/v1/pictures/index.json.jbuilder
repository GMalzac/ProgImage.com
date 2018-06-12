json.array! @pictures do |picture|
  json.extract! picture, :id, :format, :created_at, :width, :height, :url, :user_id, :updated_at
end

