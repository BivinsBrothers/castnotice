Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  namespace :admin do
    resources :events, except: [:show, :index]
  end

  resources :events, only: [:index]
  resources :categories, only: [:index]

  resource :accounts, only: [:edit, :update]
  resource :resume, only: [:edit, :update, :show]

  get "/resume/print" => "resumes#print", as: :print_resume

  resources :projects, except: [:new, :show, :index]
  resources :schools, except: [:new, :show, :index]
  resources :headshots, except: [:show, :edit]
  resources :videos, only: [:new, :index, :create, :destroy]

  get "/contact" => "contacts#new", :as => "contact"
  resource :contacts, only: [:new, :create]

  get "/dashboard" => "dashboard#show", as: :dashboard
end
