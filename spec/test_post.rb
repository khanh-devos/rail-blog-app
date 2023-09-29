require 'rails_helper'

RSpec.describe Post do
  before(:all) do
    @user = User.create(name: 'Peter', bio: 'Engineer', postCounter: 0)
    @post = Post.create(author_id: @user.id, title: 'Title', commentsCounter: 0, likesCounter: 0)
  end

  it 'title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'title should not be too long' do
    @post.title = 'a' * 251
    expect(@post).to_not be_valid
  end

  it 'commentsCounter should be present' do
    @post.commentsCounter = nil
    expect(@post).to_not be_valid
  end

  it 'commentsCounter should be an integer' do
    @post.commentsCounter = 'string'
    expect(@post).to_not be_valid
  end

  it 'commentsCounter should be greater than or equal to 0' do
    @post.commentsCounter = -1
    expect(@post).to_not be_valid
  end

  it 'likesCounter should be present' do
    @post.likesCounter = nil
    expect(@post).to_not be_valid
  end

  it 'likesCounter should be an integer' do
    @post.likesCounter = 'string'
    expect(@post).to_not be_valid
  end

  it 'likesCounter should be greater than or equal to 0' do
    @post.likesCounter = -1
    expect(@post).to_not be_valid
  end

  it 'should belong to author' do
    assc = described_class.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end

  it 'should have many likes' do
    assc = described_class.reflect_on_association(:likes)
    expect(assc.macro).to eq :has_many
  end

  it 'should have many comments' do
    assc = described_class.reflect_on_association(:comments)
    expect(assc.macro).to eq :has_many
  end

  it 'test method recent_comments' do
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title1')
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title2')
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title3')
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title4')
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title5')
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title6')
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title7')

    expect(@post.comments.size).to eql(7)
    expect(@post.recent_comments.size).to eql(5)
    expect(@post.recent_comments.first.text).to eql('title7')
  end

  it 'test commentsCounter auto increment' do
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title1')
    Comment.create(user_id: @user.id, post_id: @post.id, text: 'title2')
    post = Post.find(@post.id)
    expect(post.commentsCounter).to eql(2)
  end
end
