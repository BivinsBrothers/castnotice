Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  resources :resumes

  get "/dashboard" => "dashboard#show", as: :dashboard
end
