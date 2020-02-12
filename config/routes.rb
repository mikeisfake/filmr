Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    resources :reviews
  end

  resources :reviews

  resources :tags, only: [:show]

  root 'movies#index'
end
