Rails.application.routes.draw do
  
  # 顧客用
  devise_for :customers, skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :public do
    root to: "homes#top"
    get 'about'=>"homes#about"
    patch 'customers/withdrawal/:id', to: 'customers#withdrawal', as: "customers/withdrawal"
    resources :items, only:[:index, :show]
    resources :customers, only:[:show, :edit, :update, :quit]
    resources :cart_items, only:[:index, :update, :destroy, :destroy_all, :create]
    resources :orders, only:[:new, :check, :complete, :create, :index, :show]
    resources :deliveries, only:[:index, :edit, :create, :update, :destroy]
  end
  
  namespace :admin do
    root to: "homes#top"
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_items, only:[:update]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
