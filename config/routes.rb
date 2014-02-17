Castnotice::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
end
