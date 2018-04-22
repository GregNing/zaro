Rails.application.routes.draw do
  # devise_for :users
  devise_for :user, controllers: {  
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  namespace :account do
    resources :orders
  end
  namespace :admin do
    resources :users
    resources :orders do
      member do
       post :cancel
       post :ship
       post :shipped
       post :return       
      end
    end
    resources :products do
      member do
      patch :move_higher
      patch :move_lower
      end
    end
    resources :categories
  end
  resources :products do
    member do
    post :add_to_cart
    post :buy_or_add_to_cart
    post :edit_size_quantity
    end
  end
  resources :carts do
    collection do
      # post :checkout
      post :store_address
    end
    member do
      patch :operations
      get :checkout
    end
  end
  resources :cart_items 
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  root "products#index"
end
