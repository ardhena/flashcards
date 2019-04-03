Rails.application.routes.draw do
  resources :repositories, only: [:show, :index]
  resources :sets
end
