Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  scope "(:locale)", locale: /en|es/ do
    root to: 'home#index'
    get 'home/index'
    get 'home/about'
    get 'assignments/index'
    get 'home/health'
    post 'home/results', to: 'home#results', as: 'results'
    get 'home/results', to: 'home#results'
    resources :customers do
      resources :orders, shallow: true, except: :index
      resources :assignments, shallow: true, except: :index
    end
    resources :services
    resources :videos
    resources :categories
  # post 'customers/orders', to: 'customers/orders#create1', as: 'orders'
  # get 'customers/orders', to: 'customers/orders#index1'
  # get 'customers/order/new', to: 'customers/orders#new1', as: 'new_order'
  # get 'customers/order/:id', to: 'customers/orders#show1', as:'order_test'
  # put 'customers/order/:id', to: 'customers/orders#update1', as: 'update_order'
  # patch 'customers/order/:id', to: 'customers/orders#update1', as: 'patch_order'
  # delete 'customers/order/:id', to: 'customers/orders#destroy1', as: 'delete_order'
  # get 'customers/order/edit/:id', to: 'customers/orders#edit'
  end
end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
