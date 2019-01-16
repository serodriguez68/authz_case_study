Rails.application.routes.draw do
  # Public
  root to: 'visitors#index'
  get 'visitors/about'

  # Requires Log-in
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :clients, only: [:index, :show, :edit, :update]
  resources :drivers, only: [:index, :show, :edit, :update]
end
