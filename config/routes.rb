Rails.application.routes.draw do
  resources :movies do
    resources :reviews, only: [:index, :show, :new, :create]
  end

  get '/search', to: 'movies#search'
  post '/results', to: 'movies#results'

  resources :reviews
end
