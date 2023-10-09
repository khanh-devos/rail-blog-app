require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'GET users#index' do
    before(:each) { 
      user1 = User.create(name: 'user1')
      user2 = User.create(name: 'user2')
      visit '/users' 
    }
    
    it 'contains the placeholder text' do
      expect(page).to have_content('All users')
    end

    it 'button "New post" works fine' do
      click_button 'New post'
      expect(page).to have_content('Title')
      expect(page).to have_content('Text')
    end

    it 'input post page' do
      click_button 'New post'

      # form inside the html file
      within("form") do
        fill_in 'Title', with: 'title 1'
        fill_in 'Text', with: 'text 1'
      end

      click_button 'Add'
      expect(page).to have_content 'title 1'
      expect(page).to have_content('text 1')
    end
  end

  
end
