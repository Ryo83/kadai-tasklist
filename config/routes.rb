Rails.application.routes.draw do
  root to: 'tasks#index'
  
  #本来ならURLは「sessions/new」なところを「/login」で同じページに行くように設定
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :tasks
  
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create]
    
end