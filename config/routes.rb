Rails.application.routes.draw do
  
  root to: "users/homes#top"
  
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  
  get '/how_to' => 'users/homes#how_to'
  patch '/main/:id' => 'users/mains#exit', as: 'exit'
  post '/lists/start' => 'users/lists#start'
  delete '/memo/:id' => 'users/memos#destroy_all', as: 'destroy_all'
  
  namespace :admins do
    resources :contacts, only: [:index, :show, :update]
    resources :rooms, only: [:index, :update]
    resources :users, only: [:index, :update]
    resources :logs, only: [:index]
    resources :analysis, only: [:index]
  end
  
  scope module: :users do
    resources :rooms, except: [:edit, :destroy]
    resources :contacts, only: [:index, :new, :create]
    resources :mains, only: [:index, :edit, :update]
    resources :lists, only: [:new, :create, :update, :destroy]
    resources :memos, only: [:create, :destroy]
    resource :mypages, only: [:edit, :update]
  end
  
end
