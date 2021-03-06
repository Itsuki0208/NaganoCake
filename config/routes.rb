Rails.application.routes.draw do
  
  devise_for :customers, controllers: {
   sessions: 'customers/sessions',
   passwords: 'customers/passwords',
   registrations: 'customers/registrations'
   }
  
  scope module: :public do
   root 'homes#top'
   get 'about' => 'items#about'
  end
    
  namespace :public do
   delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
   resource :customers, only:[:show, :edit, :update]
   resources :items, only:[:index, :show]
   resources :addresses, only:[:index, :create, :update, :destroy, :edit]
   resources :cart_items, only:[:index, :create, :update, :destroy]
   resources :orders, only:[:new, :index, :show, :create]
   # ↓顧客の退会確認画面＆顧客の退会処理(ステータスの更新)
   get '/customers/unsubscribe' => 'customers#unsubscribe'
   patch '/customers/withdrawl' => 'customers#withdrawl'
   post '/orders/confirm' => 'orders#confirm'
   get '/oreders/complete' => 'orders#complete'
  end
  
  devise_for :admins, controllers: {
   sessions: 'admins/sessions',
   passwords: 'admins/passwords',
   registrations: 'admins/registrations'
   }
   
  namespace :admin do
   root :to => 'homes#top'
   resources :genres, only:[:index, :create, :edit, :update]
   resources :items, only:[:index, :new, :create, :show, :edit, :update]
   resources :customers, only:[:index, :show, :edit, :update]
   resources :orders, only:[:index, :show, :update]
   resources :order_details, only:[:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 end
