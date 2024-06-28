Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations',sessions: 'users/sessions' 
}

  get 'home/index'
  get 'bus_owner', to: 'home#bus_owner_index', as: :bus_owner_home

  resources :buses

  resources :buses do
    resources :seats
    resources :reservations
    # resources :seat_reservations#, only: [:create, :destroy]   
  end
  resources :reservations
  
  # Defines the root path route ("/")
  root "home#index"
end