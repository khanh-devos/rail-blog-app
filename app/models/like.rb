class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :post, foreign_key: 'post_id'

  def self.countLikes(post)
    post.update(likesCounter: post.likes.size)
  end

end
