require 'rails_helper'

RSpec.describe 'Post', type: 'feature' do
  describe 'test posts#index' do
    before :each do
      @user1 = User.create(name: 'user1', bio: 'bio1', photo: 'photo1')
      @user2 = User.create(name: 'user2', bio: 'bio2', photo: 'photo2')
      @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'text 1')
      @post2 = Post.create(author_id: @user1.id, title: 'Post 2', text: 'text 2')
      @post3 = Post.create(author_id: @user1.id, title: 'Post 3', text: 'text 3')
      @post4 = Post.create(author_id: @user1.id, title: 'Post 4', text: 'text 4')

      @post1.comments.create(user_id: @user1.id, text: 'from user1')
      @post1.comments.create(user_id: @user1.id, text: 'from user2')
      @post1.comments.create(user_id: @user1.id, text: 'from user3')
      @post1.comments.create(user_id: @user1.id, text: 'from user4')
      @post1.comments.create(user_id: @user1.id, text: 'from user5')
      @post1.comments.create(user_id: @user1.id, text: 'from user6')
      @post1.comments.create(user_id: @user1.id, text: 'from user7')

      @post1.likes.create(user_id: @user1.id)
      @post1.likes.create(user_id: @user1.id)

      visit "/users/#{@user1.id}/posts"
    end

    it 'contain some place holders buttons and links' do
      expect(page).to have_content('Recent Comments')
      expect(page).to have_content('user1')
      expect(page).to have_content('Posts counter: 4')

      expect(page).to have_button('New comment')
      expect(page).to have_content('Comments: 7')
      expect(page).to have_button('2 likes')

      expect(page).to have_link('Back to all posts')
    end

    it 'check number of comments is 5' do
      expect(page).to have_selector('.comment-item', count: 5)
    end

    it 'photo of user' do
      expect(find(".user_photo[src='photo1']")).not_to be_nil
    end

    it 'show only first 3 posts' do
      expect(page).to have_selector('.post-item', count: 4)
    end

    it 'check link "Back to all posts" works fine' do
      expect(page).not_to have_content('Recent Posts')
      click_link('Back to all posts')
      expect(page).to have_content('Recent Posts')
    end

    it 'if click on a post, redirect to 1 post#show' do
      click_link(href: "/users/#{@user1.id}/posts/#{@post1.id}")
      expect(page).to have_link('Back to posts')
      expect(page).to have_content('All Comments')
      expect(page).to have_selector('.post-item', count: 1)
    end
  end
end
