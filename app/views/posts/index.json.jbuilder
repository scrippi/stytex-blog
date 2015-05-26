json.array!(@posts) do |post|
  json.extract! post, :id, :subject, :content, :release_date, :tags, :user_id, :published
  json.url post_url(post, format: :json)
end
