Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  resource :resume, only: [:edit, :update]
  resources :projects, only: [:new, :create, :edit, :update]
  resources :schools, only: [:new, :create, :edit, :update]

  get "/dashboard" => "dashboard#show", as: :dashboard
end
