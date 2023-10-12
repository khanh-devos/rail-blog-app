class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'post_id', dependent: :destroy
  has_many :likes, foreign_key: 'post_id', dependent: :destroy

  belongs_to :user, foreign_key: 'author_id', counter_cache: 'posts_counter'

  def recent_comments(num = 5)
    comments.order(created_at: :desc).limit(num)
  end
end
