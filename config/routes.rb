Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sets#index'

  post '/sets', to: 'sets#create', as: 'create_set'
  get '/sets', to: 'sets#index', as: 'sets'
  get '/sets/new', to: 'sets#new', as: 'new_set'
  get '/sets/:name', to: 'sets#show', as: 'set'
end
