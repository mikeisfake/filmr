Rails.application.routes.draw do
  resources :movies do
    resources :reviews, only: [:index, :show]
  end

  resources :reviews
end
