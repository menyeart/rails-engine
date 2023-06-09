Rails.application.routes.draw do

  get "/api/v1/merchants/find", to: "api/v1/find#show"
  get "/api/v1/items/find_all", to: "api/v1/find_all#index"

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only:[:index], controller: "merchants/items"
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index]
      end
    end
  end
end
