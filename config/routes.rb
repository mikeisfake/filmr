Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  resources :movies do
    resources :reviews
  end

  resources :reviews

  resources :tags, only: [:show]

  root 'welcome#home'
end
