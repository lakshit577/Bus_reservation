Rails.application.routes.draw do
 

  # devise for user
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  # devise_for :users
  get 'home/index'
  get 'bus_owner', to: 'home#bus_owner_index', as: :bus_owner_home
  resources :buses, only: [:show, :new, :create, :destroy]  do
    # bus owner index page
    get 'bus_owner_index', on: :collection
    # buses seats
    resources :seats ,only: :new
    # booking for seats in that bus
    resources :bookings,only: :create do
      collection do
        get :reservations
        delete :destroy_reservations
        # reservations for current_user
        get :user_reservations
      end
    end
  end

  # Defines the root path route ("/")
  root "home#index"
  match "*path", to: "application#not_found", via: :all

end