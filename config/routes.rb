Shaeraneh::Application.routes.draw do
  get 'login' => 'sessions#new'
  get 'signup' => 'users#new'
  resources :sessions, :only => [:new,:create]
  resources :users, :only => :new
  
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
    resources :verses do
      member do
        put 'ascend'
        put 'descend'
      end
    end
  end
  root :to => 'poems#index'
end
