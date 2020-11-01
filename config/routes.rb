Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users
  # devise_scope :user do
  #   post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  # end
  resources :users, only: [:show, :edit, :update, :destroy] do
    resource :relationships,       only: [:create]
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  post 'posts/like/:id' => 'posts#like', as: "like_posts"
end
