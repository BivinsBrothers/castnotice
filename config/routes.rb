Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  namespace :admin do
    resources :events, except: [:show, :index]
  end

  resources :events, only: [:index]
  resources :categories, only: [:index]

  resource :accounts, only: [:edit, :update]
  resource :resume, only: [:edit, :update, :show]

  get "/r/:resume_slug" => "public_resumes#show", as: :public_resume
  get "/r/:resume_slug/print" => "public_resumes#print", as: :print_resume

  get "/search" => "search#index", as: :search

  resources :projects, except: [:new, :show, :index]
  resources :schools, except: [:new, :show, :index]
  resources :critiques, only: [:new, :create, :show]
  resources :critique_responses, only: [:create]

  resources :headshots, except: [:show, :edit]
  resources :videos, except: [:show, :update, :edit]

  get "/contact" => "contacts#new", :as => "contact"
  resource :contacts, only: [:new, :create]

  resources :messages, only: :create
  resources :conversations, only: [:index, :show, :new, :create]

  get "/dashboard" => "dashboard#show", as: :dashboard
end
