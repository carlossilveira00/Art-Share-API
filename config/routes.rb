Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/member_details', to: 'members#index'
  resources :items, only: [:index, :show, :create, :update, :destroy]
  resources :reservations, only: [:index, :create, :destroy]
  get '/completed_reservations', to: "reservations#completed_reservations"
  patch 'handle_request', to: 'reservations#handle_request'
  get '/user_items', to: "items#user_items"
  get '/pending_reservations', to: "reservations#renting_requests"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
