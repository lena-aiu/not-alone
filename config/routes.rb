Rails.application.routes.draw do
  devise_for :users
  get 'customer/index'
  get 'service/index'
  #get 'order/index'
  #get '/orders', to: 'orders#index'
  #get 'home/index'

  root to: 'customer#index'
  resources :customers do
    resources :orders, shallow: true
  end
  resources :services
  #root to: 'order#index'
  #resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
