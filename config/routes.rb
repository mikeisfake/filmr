Rails.application.routes.draw do
  resources :movies do
    resources :reviews
  end

  resources :reviews

  root 'movies#index'
end
