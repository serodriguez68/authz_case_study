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
  resources :cities, except: [:show]

  resources :services, only: [:new, :create, :index] do
    member do
      patch :client_cancel
      patch :driver_accept
      patch :driver_reject
      patch :driver_finish
    end
  end

  resources :staff_members, except: [:show, :destroy]
end
