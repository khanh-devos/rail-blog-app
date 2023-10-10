require 'rails_helper'

RSpec.describe 'Post', type: 'feature' do
  describe 'test posts#show' do
    before :each do
      @user1 = User.create(name: 'user1', bio: 'bio1', photo: 'photo1')
      @user2 = User.create(name: 'user2', bio: 'bio2', photo: 'photo2')
      @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'text 1')
      @post2 = Post.create(author_id: @user1.id, title: 'Post 2', text: 'text 2')
      @post3 = Post.create(author_id: @user1.id, title: 'Post 3', text: 'text 3')
      @post4 = Post.create(author_id: @user1.id, title: 'Post 4', text: 'text 4')

      visit "/users/#{@user1.id}/posts/#{@post1.id}"
    end

    it 'contain some place holders buttons and links' do
      expect(page).to have_content('All Comments')

      expect(page).to have_button('New comment')
      expect(page).to have_content('Comments: 0')
      expect(page).to have_button('0 likes')

      expect(page).to have_link('Back to posts')
    end

    it 'show only first 1 posts' do
      expect(page).to have_selector('.post-item', count: 1)
    end

    it 'check link "Back to posts" works fine' do
      expect(page).not_to have_content('Recent Comments')
      click_link('Back to posts')
      expect(page).to have_content('Recent Comments')
    end

    it 'check comments author name, text and likes count' do
      user1 = User.create(name: 'user1', bio: 'bio1', photo: 'photo1')
      post1 = Post.create(author_id: user1.id, title: 'Post 1', text: 'text 1')
      post1.comments.create(user_id: user1.id, text: 'from user1')
      post1.comments.create(user_id: user1.id, text: 'from user2')
      post1.likes.create(user_id: user1.id)
      post1.likes.create(user_id: user1.id)
      visit "/users/#{user1.id}/posts"

      expect(page).to have_content('user1 : from user1')
      expect(page).to have_content('user1 : from user2')
      expect(page).to have_button('2 likes')
    end

    it 'check button likes works' do
      user1 = User.create(name: 'user1', bio: 'bio1', photo: 'photo1')
      post1 = Post.create(author_id: user1.id, title: 'Post 1', text: 'text 1')
      post1.comments.create(user_id: user1.id, text: 'from user1')
      post1.comments.create(user_id: user1.id, text: 'from user2')
      post1.likes.create(user_id: user1.id)
      post1.likes.create(user_id: user1.id)
      visit "/users/#{user1.id}/posts/#{post1.id}"

      expect(page).to have_button('2 likes')
      click_button('2 likes')
      expect(page).to have_button('3 likes')
    end
  end
end
