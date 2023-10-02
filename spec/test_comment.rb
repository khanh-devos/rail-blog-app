require 'rails_helper'

RSpec.describe Comment do
  before(:all) do
    @user = User.create(
      name: 'Peter',
      bio: 'Engineer',
      posts_counter: 0
    )
    @post = Post.create(
      title: 'Blog App',
      text: 'Ruby on Rails',
      author_id: @user.id,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  it '@users comments_counter should increase by one' do
    Comment.create(text: 'Hello there!!', user_id: @user.id, post_id: @post.id)
    Comment.create(text: 'Welcome home!!', user_id: @user.id, post_id: @post.id)
    post = Post.find(@post.id)
    expect(post.comments_counter).to eq(2)
  end
end
