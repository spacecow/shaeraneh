Shaeraneh::Application.routes.draw do
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'
  resources :sessions, :only => [:new,:create]
  resources :users, :only => [:show,:new,:create]
  
  resources :locales, :only => :index
  resources :translations, :only => [:index,:create] do
    collection do
      put 'update_multiple'
    end
  end

  resources :words, :only => [:index,:new,:create,:edit,:update]
  resources :poems do
    collection do
      get 'detailed'
    end
    resources :verses, :except => [:show,:index,:new,:create,:edit,:update,:destroy] do
      member do
        put 'ascend'
        put 'descend'
      end
    end
  end
  get 'welcome' => 'poems#index'
  root :to => 'poems#index'
end
