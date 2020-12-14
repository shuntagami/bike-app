Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users,
              path: '',
              path_names: {
                sign_up: '',
                sign_in: 'login',
                sign_out: 'logout',
                registration: 'signup'
              },
              controllers: {
                registrations: 'users/registrations',
                sessions: 'users/sessions'
              }
  devise_scope :user do
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
  end

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
