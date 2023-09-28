class Post < ApplicationRecord
  after_save :count_posts

  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  belongs_to :user, foreign_key: 'author_id'

  def count_posts
    author = User.find(author_id)
    # user.update(postCounter: user.posts.size)
    author.increment!(:postCounter)
  end

  def recent_5_comments
    comments.order(created_at: :desc).limit(5)
  end
end
