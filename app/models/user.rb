class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'author_id'

  def recent_posts(num = 3)
    posts.order(created_at: :desc).limit(num)
  end
end
