Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items
      get '/items/find', to: 'item#find'
      get '/items/find_all', to: 'items#find'
      get '/merchants/find', to: 'merchant#find'
      get '/merchants/find_all', to: 'merchant#find_all'
    end
  end
end
