Rails.application.routes.draw do
 

  # devise for user
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  # devise_for :users
  get 'home/index'
  get 'bus_owner', to: 'home#bus_owner_index', as: :bus_owner_home
  resources :buses do
    # reservations for buses
    member do
      get :reservations
      delete 'destroy_reservations/:reservation_id', to: 'buses#destroy_reservations', as: 'destroy_reservation'
    end
    # reservations for current_user
    member do
      get :user_reservations
    end
    # bus owner index page
    get 'bus_owner_index', on: :collection
    # buses seats
    resources :seats 
    # booking for seats in that bus
    resources :bookings do
      # for multiple seats booking at one time
      collection do
        post 'new_multiple'
      end
    end
  end
  
  # Defines the root path route ("/")
  root "home#index"
end