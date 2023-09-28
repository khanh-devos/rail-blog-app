class Like < ApplicationRecord
  after_save :count_likes

  belongs_to :user, foreign_key: 'user_id'
  belongs_to :post, foreign_key: 'post_id'

  def count_likes
    post = Like.find(post_id)
    post.update(likesCounter: post.likes.size)
  end
end
