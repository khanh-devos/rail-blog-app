Rails.application.routes.draw do
  resources :likes
  # resources :users
  # resources :comments
  # resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: 'show_a_user'
  
  get '/users/:user_id/posts', to: 'posts#index', as: 'show_a_user_posts_comments'

  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'show_a_user_a_post_comments'

  root 'users#index'

end
