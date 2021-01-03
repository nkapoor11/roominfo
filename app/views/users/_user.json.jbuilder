json.extract! user, :id, :first_name, :last_name, :is_faculty, :password_hash, :pennkey, :created_at, :updated_at
json.url user_url(user, format: :json)
