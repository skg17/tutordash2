Rails.application.routes.draw do
  # Authentication Routes
  get 'signup', to: 'users#new', as: :signup
  resources :users, only: [:create]
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

  # Application Resources
  # Lessons: Define the collection route first to avoid ID conflict
  resources :lessons do
    # This must be processed before the default /lessons/:id route
    get :update_subjects, on: :collection 
  end

  # OAuth
  namespace :oauth do
    namespace :google_oauth2 do
      get "callback"
    end
  end

  # Settings Route
  resource :settings, only: [:edit, :update]
  get '/settings', to: redirect('/settings/edit')
  
  # Other Resources
  resources :students

  # Defines the root path route ("/")
  root 'dashboards#index'
end