require 'rails_helper'

RSpec.describe 'User', type: 'feature' do
  describe 'test user#show' do
    before :each do
      @user1 = User.create(name: 'user1', bio: 'bio1', photo: 'photo1')
      @user2 = User.create(name: 'user2', bio: 'bio2', photo: 'photo2')
      @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'text 1')
      @post2 = Post.create(author_id: @user1.id, title: 'Post 2', text: 'text 2')
      @post3 = Post.create(author_id: @user1.id, title: 'Post 3', text: 'text 3')
      @post4 = Post.create(author_id: @user1.id, title: 'Post 4', text: 'text 4')

      @post4.comments.create(user_id: @user1.id, text: 'from user1')
      @post4.comments.create(user_id: @user1.id, text: 'from user2')
      @post4.likes.create(user_id: @user1.id)
      @post4.likes.create(user_id: @user1.id)

      visit "/users/#{@user1.id}"
    end

    it 'photo of @user1' do
      expect(find("img[src='photo1']")).not_to be_nil
    end

    it "show user's name" do
      expect(page).to have_content('user1')
    end

    it 'show number of posts of user1' do
      expect(page).to have_content('Posts counter: 4')
    end

    it 'show user1\'s bio' do
      expect(page).to have_content('bio1')
    end

    it 'show only first 3 posts of user1' do
      expect(page).to have_selector('.post-item', count: 3)
    end

    it 'See the link show all posts' do
      expect(page).to have_link('SHOW ALL POSTS')
    end

    it 'if click on a post, redirect to 1 post#show' do
      visit("/users/#{@user1.id}/posts/#{@post1.id}")
      expect(page).to have_link('Back to posts')
      expect(page).to have_content('Post 1')
      expect(page).to have_selector('.post-item', count: 1)
    end

    it 'check link "show all posts" works fine' do
      click_link('SHOW ALL POSTS')
      expect(page).to have_selector('.post-item', count: 4)
      expect(page).to have_content('Recent Comments')
    end

    it 'check link "Back to users" works fine' do
      click_link('Back to users')
      expect(page).to have_content('All users')
      expect(page).not_to have_content('Recent Posts')
    end
  end
end
