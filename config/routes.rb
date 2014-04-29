Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  namespace :admin do
    resources :events, except: [:show, :index]
  end

  resources :events, only: [:index]

  resource :accounts, only: [:edit, :update]
  resource :resume, only: [:edit, :update, :show]

  resources :projects, only: [:new, :create, :edit, :update]
  resources :schools, only: [:new, :create, :edit, :update]
  resources :headshots, only: [:new, :index, :create, :update, :destroy]
  resources :videos, only: [:new, :index, :create, :destroy]

  get "/contact" => "contacts#new", :as => "contact"
  resource :contacts, only: [:new, :create]

  get "/dashboard" => "dashboard#show", as: :dashboard
end
