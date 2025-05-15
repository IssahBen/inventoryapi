# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      post 'products', to: 'products#create'
      get 'products', to: 'products#products_list'
      get 'products/:id', to: 'products#edit_product'
      post 'products/:id', to: 'products#update_product'
      post 'buy', to: 'transactions#create'
      get 'reports', to: 'reports#sales_report'
      get 'reports/stock', to: 'reports#stock_report'
      get 'reports/transactions', to: 'reports#transaction_report'
      devise_scope :user do
        post 'register', to: 'registrations#create'
      end
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
