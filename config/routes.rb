Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :users do
    resource :relationships, only: %i[create destroy]
    member do
      get :following, :followers
    end
  end

  resources :posts do
    collection do
      get :cities_select
      get :popular
      get :feed
      get :search
    end
    resources :comments, only: %i[create destroy]
  end

  post 'posts/like/:id' => 'posts#like', as: 'like_posts'
end
