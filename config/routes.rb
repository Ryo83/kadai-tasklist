Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'tasks#index'

    #resourcesの中には、RESTful(index,show,new,create,edit,update,destroy)というルーティングがすべて収まっている
    resources :tasks
end
