Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: "registrations" }

  resources :movies, only: [:new, :index, :show, :create] do
    resources :reviews, only: [:index, :create, :new]
  end
  resources :users, only: :show, path: 'profile' do
    resources :reviews, only: [:index]
    resources :movies, only: [:index]
    member do
      get :follow
      get :unfollow
      get :followers
      get :following
    end
  end

  resources :reviews, except: [:new, :index]
  resources :tags, only: [:show]

  get '/search', to: 'movies#new'
  get '/dashboard', to: 'users#dashboard'

  root 'welcome#index'
end
