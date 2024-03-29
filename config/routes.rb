Castnotice::Application.routes.draw do
  constraints RegistrationAccountTypeConstraint do
    devise_for :users,
      path_names: { sign_up: "sign_up/:account_type" },
      controllers: {
        registrations: "registrations",
        sessions: "sessions",
        passwords: "passwords"
      }
  end

  namespace :admin do
    resources :events, except: [:show, :index] do
      resources :roles
    end
  end

  namespace :superadmin do
    resources :camps
    resources :users, only: [:index, :edit, :update]
    get "/mentors/invite", to: "mentors#invite"
    post "/mentors/send_invite", to: "mentors#send_invite"
  end

  resource :promo, only: [:create, :show], controller: "promo"

  resources :events, only: [:index]
  resources :categories, only: [:index]

  resource :membership, only: [:create, :new]
  resource :camper_registration, only: [:new, :create, :show]

  resource :accounts, only: [:edit, :update]
  resource :resume, only: [:edit, :update, :show]

  get "/r/:resume_slug" => "public_resumes#show", as: :public_resume
  get "/r/:resume_slug/print" => "public_resumes#print", as: :print_resume

  get "/search" => "search#index", as: :search

  resources :projects, except: [:new, :show, :index]
  resources :schools, except: [:new, :show, :index]
  resources :critiques, only: [:new, :create, :show, :index] do
    resource :response, only: [:create], controller: "critique_responses"
  end

  resources :headshots, except: [:show, :edit, :index]
  resources :videos, except: [:show, :update, :edit] do
    post "video_from_link", to: "videos#create_from_link", on: :collection
  end

  # Zencoder notification endpoint.
  post "/video_statuses" => "video_statuses#notify"

  get "/contact" => "contacts#new", :as => "contact"
  resource :contacts, only: [:new, :create]

  resources :messages, only: :create
  resources :conversations, only: [:index, :show, :new, :create]

  get "/dashboard" => "dashboard#show", as: :dashboard
end
