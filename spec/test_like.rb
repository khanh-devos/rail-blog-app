require 'rails_helper'

RSpec.describe Like do
  before(:all) do
    @user = User.create(
      name: 'Peter',
      bio: 'Engineer',
      postCounter: 0
    )
    @post = Post.create(
      # new title
      title: 'Blog App',
      text: 'Ruby on Rails',
      author_id: @user.id,
      commentsCounter: 0,
      likesCounter: 0
    )
  end

  it '@posts likesCounter auto increment' do
    Like.create(user_id: @user.id, post_id: @post.id)
    Like.create(user_id: @user.id, post_id: @post.id)
    post = Post.find(@post.id)
    expect(post.likesCounter).to eq(2)
  end
end
