Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :movies do
    resources :reviews
  end
  resources :users, only: [:show], path: 'profile' do
    member do
      get :follow
      get :unfollow
    end
  end
  resources :reviews
  resources :follows, only: [:index], path: 'following'
  resources :tags, only: [:show]

  get '/dashboard', to: 'users#dashboard'
  post '/dashboard', to: 'users#dashboard'
  post '/profile/:id', to: 'users#show'

  root 'welcome#index'
end
