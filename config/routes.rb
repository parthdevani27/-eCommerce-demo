Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'  
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
     get "/products",to: "products#index"
     get "/products/:id",to: "products#view"

     get "/carts", to: "carts#index"
     get "/carts/add/:id", to: "carts#add"
     delete "/carts/:id", to: "carts#delete"

      get "/orders", to: "orders#index"
      get "/orders/add", to: "orders#add"

      get "/products/increment/:id" , to: "carts#increment"
      get "/products/decrement/:id" , to: "carts#decrement"
    #  resources :carts
end
