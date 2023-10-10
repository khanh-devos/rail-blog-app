require 'rails_helper'
RSpec.describe "Post", type: 'feature' do
  context 'test post#index' do
    before :each do
      user1 = User.create(name: 'user1', bio: 'bio1', photo: 'photo1')
      user2 = User.create(name: 'user2', bio: 'bio2', photo: 'photo2')
      post1 = Post.create(author_id: user1.id, title: 'Post 1', text: 'text 1')
      post2 = Post.create(author_id: user1.id, title: 'Post 2', text: 'text 2')
      visit "/users/#{user1.id}"
    end
    it 'contain some place holders' do
      expect(page).to have_content('Recent Posts')
      expect(page).to have_content('user1')
      expect
    end
    it 'photo of user' do
      expect(find(".user_photo[src='photo1']")).not_to be_nil
    end
  end
end