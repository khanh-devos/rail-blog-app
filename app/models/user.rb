class User < ApplicationRecord
  has_one_attached :photo
  
  has_many :comments
  has_many :likes
  has_many :posts, foreign_key: :author_id
end
