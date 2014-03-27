Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  resource :user, only: [:new, :create, :edit, :update]
  resource :resume, only: [:new, :create, :edit, :update]
  resources :projects, only: [:new, :create, :edit, :update]
  resources :schools, only: [:new, :create, :edit, :update]

  get "/dashboard" => "dashboard#show", as: :dashboard

  get "/how_it_works" => "pages#how_it_works"
  get "/pricing"      => "pages#pricing"
  get "/about_us"     => "pages#about_us"
  get "/contact"      => "pages#contact"
  get "/calendar"     => "pages#calendar"
  get "/privacy"      => "pages#privacy"
  get "/tos"          => "pages#tos"

  root to: "pages#index"
end
