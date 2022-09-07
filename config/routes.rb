Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources "users"
  resources :posts do
    resources :likes
    resources :comments do
      resources :likes
    end
  end
  post 'friendships/create'
  resources 'likes'
  # post 'comments/new'
  # post 'comments/create'
  get 'posts/index'
  get 'posts/show'
  post 'posts/new'
  post 'posts/create'
end
