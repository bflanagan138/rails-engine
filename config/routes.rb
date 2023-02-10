Rails.application.routes.draw do
  
  get '/api/v1/merchants/find_all', to: 'api/v1/merchants#index'
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index, :show], controller: :merchant_items
      end
      resources :items do
        resources :merchant, only: :index, controller: :item_merchant
      end
      get '/items/find', to: 'item#find'
      get '/items/find_all', to: 'items#find'
      get '/merchants/find', to: 'merchant#find'
    end
  end
end
