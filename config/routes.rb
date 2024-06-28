Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations',sessions: 'users/sessions' 
}

  get 'home/index'
  get 'bus_owner', to: 'home#bus_owner_index', as: :bus_owner_home

  resources :buses

  resources :buses do
    resources :seats do
      member do
        delete :unselect_seat
      end
    end
    resources :reservations
    resources :payments
  
  end
 
  root "home#index"
end