require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'GET users#index' do
    before :each do
      @user1 = User.create(name: 'user1', photo: 'photo1')
      @user2 = User.create(name: 'user2', photo: 'photo2')
      visit '/users'
    end

    it 'contains the placeholder text and usernames' do
      expect(page).to have_content('All users')
      expect(page).to have_content('user1')
      expect(page).to have_content('user2')
      expect(page).to have_content('Posts counter')
    end

    it 'photo of user' do
      expect(find(".user_photo[src='photo1']")).not_to be_nil
    end

    it 'link to a user\'s posts' do
      # context
      user3 = User.create(name: 'user3')
      visit '/users'
      click_link(href: "/users/#{user3.id}")

      # user interaction
      expect(page).to have_content('Recent Posts')
      expect(page).to have_content('user3')
      expect(page).to have_link('SHOW ALL POSTS', href: "/users/#{user3.id}/posts")
    end

    it 'button "New post" works fine' do
      click_button 'New post'
      expect(page).to have_content('Title')
      expect(page).to have_content('Text')
      expect(page).to have_selector('form')
      expect(page).to have_button('Add')
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
