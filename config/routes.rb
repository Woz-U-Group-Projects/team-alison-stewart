require 'resque_web'

Rails.application.routes.draw do
  # Error pages
  %w( 404 422 500 503 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  # Resque web interface
  resque_web_constraint = lambda do |request|
    current_user = User.find_by(id: request.session[:user_id])
    current_user && current_user.is?(:admin)
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine => '/admin/resque'
  end

  # Active Admin
  ActiveAdmin.routes(self)

  # Custom admin routes
  namespace :admin do
    resources :demo_videos do
      resources :features
    end

    resources :id_card_requests do
      resources :comments
      resources :nodes
    end

    resources :id_card_templates do
      resources :nodes
    end

    resources :important_date_types do
      resources :important_date_type_programs
    end

    resources :look_books do
      resources :photos
    end

    resources :products do
      resources :photos
    end

    resources :schools do
      resources :addresses
      resources :convocations
      resources :photos
      resources :program_notes
    end

    resources :services do
      resources :features
      resources :photos
    end

    resources :settings do
      collection do
        patch :update_all
      end
    end

    resources :sittings do
      resources :features
    end
  end

  # API routes
  namespace :api do
    namespace :v1 do
      resources :id_card_requests, only: [:index, :update]
    end
  end

  # Root
  root 'root#show'

  resources :bookings, only: [] do
    collection do
      get :thank_you
    end
  end

  resources :contact_requests, only: [:create]

  resources :feedbacks, only: [:new, :create] do
    collection do
      get :thank_you
    end
  end


  resources :employees, only: [:index]

  resources :id_card_requests, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get :find
    end

    member do
      get :thank_you
    end
  end

  resources :products, only: [:index]

  resources :schools, only: [:index, :show] do
    collection do
      get :book
      get :find
    end

    resources :bookings, only: [:create, :edit, :update] do
      member do
        get :confirmation
      end

      resources :payments, only: [:new, :create]
    end

    resources :events, only: [:index]

    resources :programs, only: [:show]

    resources :registrations, only: [:new, :create] do
      collection do
        get :confirmation
      end
    end
  end

  resources :services, only: [:show]

  resource :session

  # Static page routes
  StaticController::STATIC_PAGES.each do |page|
    get "/#{page}", to: "static##{page}", as: "#{page}_static"
  end

  # Load balancer health check
  get '/health_check' => 'health_check#index'
end
