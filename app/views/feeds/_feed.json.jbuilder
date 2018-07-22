json.extract! feed, :id, :title, :url, :description, :created_at, :updated_at
json.url feed_url(feed, format: :json)
