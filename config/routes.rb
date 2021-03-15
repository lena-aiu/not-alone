Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  scope "(:locale)", locale: /en|es/ do
    root to: 'home#index'
    get 'home/index'
    get 'home/about'
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
    resources :user_rolles
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
