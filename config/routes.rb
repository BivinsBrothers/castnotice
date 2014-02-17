Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get "/dashboard" => "dashboard#show", as: :dashboard
end
