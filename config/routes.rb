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
  
  namespace :admins do
    resources :contacts, only: [:index, :show, :update]
    resources :rooms, only: [:index, :update]
    resources :users, only: [:index, :update]
    resources :logs, only: [:index]
    resources :analysis, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
