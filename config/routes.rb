Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  resource :resume

  get "/dashboard" => "dashboard#show", as: :dashboard
end
