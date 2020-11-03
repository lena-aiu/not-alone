Rails.application.routes.draw do
  devise_for :users
  get 'customer/index'
  get 'service/index'
  #get 'order/index'
  #get '/orders', to: 'orders#index'
  #get 'home/index'

  root to: 'customer#index'
  resources :customers do
    resources :orders, shallow: false
  end
  get '/orders', to: 'orders#index1'
  get '/order', to: 'orders#show1'
  put '/order', to: 'orders#update1'
  patch '/order', to: 'orders#update1'
  delete '/order', to: 'orders#destroy1'
  get '/order/new', to: 'orders#new1'
  get '/order/edit', to: 'orders#edit1'
   
  resources :services
  #root to: 'order#index'
  #resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
