Rails.application.routes.draw do
  
  devise_for :customers, controllers: {
   sessions: 'customers/sessions',
   passwords: 'customers/passwords',
   registrations: 'customers/registrations'
   }
  
  scope module: :customers do
   root 'homes#top'
   get 'about' => 'items#about'
  end
    
  namespace :customers do
   resources :customers, only:[:show, :edit, :update]
   # ↓顧客の退会確認画面＆顧客の退会処理(ステータスの更新)
   get '/customers/unsubscribe' => 'customers#unsubscribe'
   patch '/customers/withdrawl' => 'customers#withdrawl'
  end
  
  devise_for :admins, controllers: {
   sessions: 'admins/sessions',
   passwords: 'admins/passwords',
   registrations: 'admins/registrations'
   }
   
  namespace :admin do
   root :to => 'homes#top'
   resources :items, only:[:index, :new, :create, :show, :edit, :update]
   resources :customers, only:[:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 end