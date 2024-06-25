Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}

  # devise_for :users
  get 'home/index'
  get 'bus_owner', to: 'home#bus_owner_index', as: :bus_owner_home
  resources :buses
  
  # resources :bus_owners  
  # Defines the root path route ("/")
  root "home#index"
end