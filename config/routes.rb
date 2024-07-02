Rails.application.routes.draw do
  get 'bookings/new'
  get 'bookings/create'
  devise_for :users, controllers: {
  registrations: 'users/registrations',sessions: 'users/sessions' 
}

  get 'home/index'
  get 'bus_owner', to: 'home#bus_owner_index', as: :bus_owner_home
  resources :buses do
    get 'bus_owner_index', on: :collection
    resources :seats do
      resources :bookings
    end
  end

  
  end
 
  root "home#index"
end