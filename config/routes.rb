Rails.application.routes.draw do
  # Public
  root to: 'visitors#index'
  get 'visitors/about'

  # Requires Log-in
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
