json.extract! post, :id, :author_id, :title, :text, :commentsCounter, :likesCounter, :created_at, :updated_at
json.url post_url(post, format: :json)
