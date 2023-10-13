require 'swagger_helper'

describe 'Comments API' do
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
  end

  path "api_v1_user_post_comments" do
    get "show all comments" do
      tags 'Comments'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { 
        success: true,
      }, name: 'basic', summary: 'Request example description'
  
        response '200', 'comments found' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              text: { type: :string },
            },
            required: ['text']
  
          let(i) {
            @user1 = User.create(name: 'user1', bio: 'bio1', photo: 'photo1')
            @post1 = Post.create(author_id: @user1.id, title: 'Post 1', text: 'text 1')
          
            @post1.comments.create(user_id: @user1.id, text: 'from user1')
            @post1.comments.create(user_id: @user1.id, text: 'from user2')
          }
            
          

          run_test!
        end

        response '404', 'blog not found' do
          let(:id) { 'invalid' }
          run_test!
        end
    
        response '406', 'unsupported accept header' do
          let(:'Accept') { 'application/foo' }
          run_test!
        end


    end


  end


end