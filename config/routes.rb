Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friends, only: [:create, :destroy]
  get "my_friends", to: "friends#index"
  devise_for :users
  root 'pages#welcome'
  get "my_portfolio", to: "users#my_portfolio"
  get "search_stock", to: "stocks#search"
  get "search_friend", to: "friends#search"
  resources :users, only: [:show]
end
