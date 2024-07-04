Rails.application.routes.draw do
  get 'bookings/new'
  get 'bookings/create'
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}

  # devise_for :users
  get 'home/index'
  get 'bus_owner', to: 'home#bus_owner_index', as: :bus_owner_home
  resources :buses do
    member do
      get :reservations
    end
    get 'bus_owner_index', on: :collection
    resources :seats 
    resources :bookings do
      collection do
        post 'new_multiple'
      end
    end
  end
  
  # resources :bus_owners  
  # Defines the root path route ("/")
  root "home#index"
end