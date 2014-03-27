Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  resource :user, only: [:new, :create, :edit, :update]
  resource :resume, only: [:new, :create, :edit, :update]
  resources :projects, only: [:new, :create, :edit, :update]
  resources :schools, only: [:new, :create, :edit, :update]

  get "/dashboard" => "dashboard#show", as: :dashboard

  get "/how_it_works" => "pages#show", id: "how_it_works"
  get "/pricing"      => "pages#show", id: "pricing"
  get "/about"        => "pages#show", id: "about"
  get "/contact"      => "pages#show", id: "contact"
  get "/calendar"     => "pages#show", id: "calendar"
  get "/privacy"      => "pages#show", id: "privacy"
  get "/tos"          => "pages#show", id: "tos"

  root to: "pages#index"
end
