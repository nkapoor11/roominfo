json.extract! comment, :id, :content, :room_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
