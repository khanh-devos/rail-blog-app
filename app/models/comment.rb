class Comment < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'user_id'

  def self.countComments(post)
    post.update(commentsCounter: post.comments.size)
  end

end
