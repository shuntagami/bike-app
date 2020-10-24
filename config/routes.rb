Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update, :destroy] do
    resource :relationships,       only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end
end
