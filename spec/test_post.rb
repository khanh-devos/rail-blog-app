require 'spec_helper'
require 'rails_helper'

RSpec.describe Post do
  context 'Text class User: ' do
    before :each do
      @title = 'title'
      @text = 'text'
      @post = Post.new(title: @title, text: @text)
    end

    it 'test all attrs' do
      expect(@post.title).to eql(@title)
      expect(@post.text).to eql(@text)
    end

    it 'validate title, max length 250' do
      post1 = Post.new(title: nil, text: @text)
      expect(post1).to be_invalid

      long_260_title = Array.new(251, 'a').join
      post2 = Post.new(title: long_260_title, text: @text)
      expect(post2).to be_invalid
    end

    it 'validate commentsCounter greater_than_or_equal_to 0 ' do
      post1 = Post.new(title: 'title', text: @text, commentsCounter: -1)
      expect(post1).to be_invalid
    end

    it 'validate likesCounter greater_than_or_equal_to 0 ' do
      post1 = Post.new(title: 'title', text: @text, likesCounter: -1)
      expect(post1).to be_invalid
    end
  end
end
