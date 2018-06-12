json.array! @pictures do |picture|
  json.extract! picture, :id, :format, :created_at, :updated_at
end

