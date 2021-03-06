Rails.application.routes.draw do
  
  #ルートパス(未ログイン時トップ画面)
  root to: "users/homes#top"
  
  #gem devise 管理者
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  
  #gem devise 利用者
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  
  #使い方ページの表示
  get '/how_to' => 'users/homes#how_to'
  
  #ルーム退会処理(keyカラムをnilに書き換える)
  patch '/main/:id' => 'users/mains#exit', as: 'exit'
  
  #タスクを開始したときの処理(タスクテーブルにデータが作成される)
  post '/lists/start' => 'users/lists#start'
  
  #メモを全て削除する処理
  delete '/memo/:id' => 'users/memos#destroy_all', as: 'destroy_all'
  
  #URLにadminsを含ませる
  namespace :admins do
    resources :contacts, only: [:index, :show, :update]
    resources :rooms, only: [:index, :update]
    resources :users, only: [:index, :update]
    resources :logs, only: [:index]
    resources :analysis, only: [:index]
  end
  
  #URLにusersを含ませない
  scope module: :users do
    resources :rooms, except: [:edit, :destroy]
    resources :contacts, only: [:index, :new, :create]
    resources :mains, only: [:index, :edit, :update]
    resources :lists, only: [:new, :create, :update, :destroy]
    resources :memos, only: [:create, :destroy]
    #URLにidをもたせないため単数形
    resource :mypages, only: [:edit, :update]
  end
  
end
