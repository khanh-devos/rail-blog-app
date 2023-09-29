class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :commentsCounter, numericality: { greater_than_or_equal_to: 0 }
  validates :likesCounter, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  belongs_to :user, foreign_key: 'author_id', counter_cache: 'postCounter'

  def recent_comments(num = 5)
    comments.order(created_at: :desc).limit(num)
  end
end
