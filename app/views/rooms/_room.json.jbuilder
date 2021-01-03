json.extract! room, :id, :location, :number, :room_type, :description, :created_at, :updated_at
json.url room_url(room, format: :json)
