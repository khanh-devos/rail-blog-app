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

    it 'contain some place holders buttons and links' do
      expect(page).to have_content('Recent Posts')
      expect(page).to have_content('user1')
      expect(page).to have_content('Post 4')
      expect(page).to have_content('Posts counter: 4')

      expect(page).to have_button('New comment')

      expect(page).to have_link('Back to users')
      expect(page).to have_link('SHOW ALL POSTS')
    end

    it 'show comments counter and likes couter post4' do
      expect(page).to have_content('Comments: 2')
      expect(page).to have_button('2 likes')
    end

    it 'photo of user' do
      expect(find(".user_photo[src='photo1']")).not_to be_nil
    end

    it 'show only first 3 posts' do
      expect(page).to have_selector('.post-item', count: 3)
    end

    it 'check link "Back to users" works fine' do
      click_link('Back to users')
      expect(page).to have_content('All users')
      expect(page).not_to have_content('Recent Posts')
    end

    it 'check link "show all posts" works fine' do
      click_link('SHOW ALL POSTS')
      expect(page).to have_selector('.post-item', count: 4)
      expect(page).to have_content('Recent Comments')
    end

    it 'check first button "New comment" works fine' do
      expect(page).not_to have_button('Save Comment')
      first('button[class="link-btn"]').click
      expect(page).to have_button('Save Comment')
    end
  end
end
