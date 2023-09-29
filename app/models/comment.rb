class Comment < ApplicationRecord
  after_save :count_comments
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'user_id'

  def count_comments
    post = Post.find(post_id)
    post.update(commentsCounter: post.comments.size)
  end
end
