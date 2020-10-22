Rails.application.routes.draw do
  devise_for :users
  get 'customer/index'
  #get 'order/index'
  #get '/orders', to: 'orders#index'

  root to: 'customer#index'
  resources :customers
  #root to: 'order#index'
  #resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
