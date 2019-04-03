Rails.application.routes.draw do
  get "/", to: "repositories#index"

  resources :repositories, only: [:show, :index]
  resources :sets, only: [:show]
end
