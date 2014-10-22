Rails.application.routes.draw do
  root to: 'visitors#index'

  get 'postos-de-gasolina' => 'serconprev#index', :as => 'serconprev'

  devise_for :users
  resources :users
end
