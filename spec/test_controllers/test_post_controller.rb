require 'rails_helper'

RSpec.describe 'Posts', type: 'request' do
  describe 'GET posts#index' do
    before :each do
      user = User.create(name: 'name for test')
      user.posts.create(title: 'Post test', text: 'This is for testing')
      get "/users/#{user.id}/posts"
    end

    it 'is success ' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'renders index template with right text' do
      expect(response.body).to match('Posts & Comments')
      expect(response.body).to match('name for test')
    end

    it 'does not render a different template' do
      expect(response).to_not render_template(:show)
    end
  end

  describe 'GET posts#show' do
    before :each do
      user = User.create(name: 'test')
      post = Post.create(author_id: user.id, title: 'Post test', text: 'This is for testing')
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'is success ' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'renders "show template" with right text' do
      expect(response.body).to match('Post test')
      expect(response.body).to match('Show Comments')
    end

    it 'does not render a different template' do
      expect(response).to_not render_template(:index)
    end
  end
end
