require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'GET users#index' do
    before :each do
      @user1 = User.create(name: 'user1', photo: 'photo1')
      @user2 = User.create(name: 'user2', photo: 'photo2')
      @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'text 1')
      visit '/users'
    end

    it 'can see names of users' do
      expect(page).to have_content('user1')
      expect(page).to have_content('user2')
    end

    it 'photos of users' do
      expect(find("img[src='photo1']")).not_to be_nil
      expect(find("img[src='photo2']")).not_to be_nil
    end

    it 'number of posts of each user' do
      within("a[href='/users/#{@user1.id}']") do
        expect(page).to have_content('Posts counter: 1')
      end

      within("a[href='/users/#{@user2.id}']") do
        expect(page).to have_content('Posts counter: 0')
      end
    end

    it 'click on a user, redirect to that user\'s show page' do
      click_link(href: "/users/#{@user2.id}")

      expect(page).to have_content('Recent Posts')
      expect(page).to have_content('user2')
      expect(page).to have_link('SHOW ALL POSTS', href: "/users/#{@user2.id}/posts")
    end

    it 'input a new post successfully' do
      click_button 'New post'

      # inside the html file
      within('form') do
        fill_in 'Title', with: 'title 1'
        fill_in 'Text', with: 'text 1'
      end

      click_button 'Add'
      expect(page).to have_content('Post created successfully!')
      expect(page).to have_content('title 1')
      expect(page).to have_content('text 1')
    end

    it 'input a new post failure' do
      click_button 'New post'

      # form inside the html file
      within('form') do
        fill_in 'Text', with: 'text 1'
      end

      click_button 'Add'
      expect(page).not_to have_content('Post created successfully!')
      expect(page).not_to have_content('text 1')
    end
  end
end
