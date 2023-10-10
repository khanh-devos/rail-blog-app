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

      @post1.comments.create(user_id: @user1.id, text: 'from user1')
      @post1.comments.create(user_id: @user1.id, text: 'from user2')
      @post1.comments.create(user_id: @user2.id, text: 'from user3')
      @post1.comments.create(user_id: @user2.id, text: 'from user4')
      @post1.comments.create(user_id: @user1.id, text: 'from user5')
      @post1.comments.create(user_id: @user1.id, text: 'from user6')
      @post1.comments.create(user_id: @user1.id, text: 'from user7')

      @post1.likes.create(user_id: @user1.id)

      visit "/users/#{@user1.id}/posts/#{@post1.id}"
    end

    it 'show post title and author\'s name' do
      expect(page).to have_content('Post 1')
      expect(page).to have_content('user1')
    end

    it 'show 7 comments and 1 likes' do
      expect(page).to have_content('Comments: 7')
      expect(page).to have_button('1 likes')
    end

    it 'show only first 1 posts' do
      expect(page).to have_selector('.post-item', count: 1)
    end

    it 'check link "Back to posts" works fine' do
      expect(page).not_to have_content('Recent Comments')
      click_link('Back to posts')
      expect(page).to have_content('Recent Comments')
    end

    it 'show users names and their comments' do
      expect(page).to have_content('user1 : from user1')
      expect(page).to have_content('user1 : from user2')
      expect(page).to have_content('user2 : from user3')
      expect(page).to have_content('user2 : from user4')
    end

    it 'check button "likes" works' do
      expect(page).to have_button('1 likes')
      click_button('1 likes')
      expect(page).to have_button('2 likes')
    end
  end
end
