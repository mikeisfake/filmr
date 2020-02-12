Rails.application.routes.draw do
  resources :movies do
    resources :reviews
  end

  resources :reviews

  resources :tags, only: [:show]

  root 'movies#index'
end
