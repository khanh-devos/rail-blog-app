require 'rails_helper'

RSpec.describe User do
  subject { User.create(name: 'John Doe', postCounter: 0) }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'postCounter should be present' do
    subject.postCounter = nil
    expect(subject).to_not be_valid
  end

  it 'postCounter should be greater than or equal to 0' do
    subject.postCounter = -1
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should have many posts' do
    assc = described_class.reflect_on_association(:posts)
    expect(assc.macro).to eql :has_many
  end

  it 'should have many comments' do
    assc = described_class.reflect_on_association(:comments)
    expect(assc.macro).to eq :has_many
  end

  it 'should have many likes' do
    assc = described_class.reflect_on_association(:likes)
    expect(assc.macro).to eq :has_many
  end

  it 'test method recent_posts' do
    Post.create(author_id: subject.id, title: 'title1', commentsCounter: 0, likesCounter: 0)
    Post.create(author_id: subject.id, title: 'title2', commentsCounter: 0, likesCounter: 0)
    Post.create(author_id: subject.id, title: 'title3', commentsCounter: 0, likesCounter: 0)
    Post.create(author_id: subject.id, title: 'title4', commentsCounter: 0, likesCounter: 0)

    expect(subject.posts.size).to eql(4)
    expect(subject.recent_posts.size).to eql(3)
    expect(subject.recent_posts.first.title).to eql('title4')
  end

  it 'test postCounter auto increment' do
    Post.create(author_id: subject.id, title: 'title1', commentsCounter: 0, likesCounter: 0)

    user = User.find(subject.id)
    expect(user.postCounter).to eql(1)
  end
end
