Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'pages#home', as: 'home'
  get 'profile', to: 'pages#profile'

  devise_for :users

  resources :trips, except: [:show] do
    resources :days, only: [ :new, :create ]
  end

  resources :days, only: [ :destroy ]


  resources :places, only: [ :new, :create, :destroy]

  resources :vehicles, only: [ :new, :create, :edit]

  # Defines the root path route ("/")
  # root "posts#index"
end
