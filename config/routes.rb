Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # --- Authentication Routes ---
  # Sign Up (Users#new, Users#create)
  get 'signup', to: 'users#new', as: :signup
  resources :users, only: [:create] # Handles the POST request from the sign up form

  # Login/Logout (Sessions#new, Sessions#create, Sessions#destroy)
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  # -----------------------------

  # Application Resources
  resources :students
  resources :lessons
  resources :payments # Assuming you have a PaymentsController

  # Defines the root path route ("/")
  root 'dashboards#index'

  # Health Check for deployment
  get "up" => "rails/health#show", as: :rails_health_check
end