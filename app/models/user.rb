class User < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :postCounter, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'author_id'

  def recent_posts(num = 3)
    posts.order(created_at: :desc).limit(num)
  end
end
