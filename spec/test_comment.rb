require 'rails_helper'

RSpec.describe Comment do
  before(:all) do
    @user = User.create(
      name: 'Peter',
      bio: 'Engineer',
      postCounter: 0
    )
    @post = Post.create(
      title: 'Blog App',
      text: 'Ruby on Rails',
      author_id: @user.id,
      commentsCounter: 0,
      likesCounter: 0
    )
  end

  it '@users commentsCounter should increase by one' do
    Comment.create(text: 'Hello there!!', user_id: @user.id, post_id: @post.id)
    Comment.create(text: 'Welcome home!!', user_id: @user.id, post_id: @post.id)
    post = Post.find(@post.id)
    expect(post.commentsCounter).to eq(2)
  end
end
