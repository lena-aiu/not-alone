Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'home#index'
  get 'home/index'
  get 'home/about'
  get 'assignments/index'
  #root to: 'customer/index'
  # devise_scope :user do
  #   root to: 'devise/sessions#new'
  # end
  resources :customers do
    resources :orders, shallow: false
    resources :assignments, shallow: true
  end

  get 'customer/index'
  #get 'service/index'
  #get 'order/index'
  #get '/orders', to: 'orders#index'
  #get 'home/index'
  

  resources :services
  resources :videos
  resources :customers do
    resources :orders, shallow: false
  end

  post '/orders', to: 'orders#create1', as: 'orders'
  get '/orders', to: 'orders#index1'
  get '/order/new', to: 'orders#new1', as: 'new_order'
  get '/order/:id', to: 'orders#show1', as:'order'
  put '/order/:id', to: 'orders#update1'
  patch '/order/:id', to: 'orders#update1'
  delete '/order/:id', to: 'orders#destroy1'
  get '/order/edit/:id', to: 'orders#edit1', as: 'edit_order'

  # devise_scope :user do
  #   root to: 'devise/sessions#new'
  # end
  #get 'order/index'
  #get '/order/:id', to: 'orders#show1'
  #get '/orders', to: 'orders#index'
  #post '/order/create/:id', to: 'orders#create1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
