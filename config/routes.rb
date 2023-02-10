Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchants/search#index'
      # get '/items/find', to: 'item#find'
      # get '/items/find_all', to: 'items#find'
      # get '/merchants/find', to: 'merchant#find'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index, :show], controller: :merchant_items
      end
      resources :items do
        resources :merchant, only: :index, controller: :item_merchant
      end
    end
  end

end