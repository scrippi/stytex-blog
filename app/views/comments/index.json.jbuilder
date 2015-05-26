json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :permitted, :user_id, :author_name, :author_email
  json.url comment_url(comment, format: :json)
end
