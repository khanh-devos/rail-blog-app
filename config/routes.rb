Rails.application.routes.draw do
  devise_for :users
  get '/users/sign_out', to: 'users#user_sign_out', as: 'sign_out'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new destroy] do
      resources :comments, only: %i[destroy]
      resources :likes, only: %i[]
    end
  end
  

  get '/users/:id/posts/new', to: 'posts#new', as: 'post_new'
  post '/users/:id/posts/create', to: 'posts#create', as: 'post_create'

  get '/users/:user_id/posts/:id/comments/new', to: 'comments#new', as: 'comment_new'
  post '/users/:user_id/posts/:id/comments/create', to: 'comments#create', as: 'comment_create'

  post '/users/:user_id/posts/:id/likes/create', to: 'likes#create', as: 'like_create'

  # get '/users/:user_id/posts', to: 'posts#index', as: 'show_a_user_posts_comments'
  # get '/users/:user_id/posts/:id', to: 'posts#show', as: 'show_a_user_a_post_comments'

  root 'users#index'

  # for API
  get '/api/users', to: 'users#index_api'
  get '/api/users/:user_id/posts/:id', to: 'posts#show_api'
  
  post '/api/auth/login', to: 'authentication#login'

  namespace :api, default: {format: :json} do
    namespace :v1 do
      resources :users, only: %i[index] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end 

end
