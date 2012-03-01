Shaeraneh::Application.routes.draw do
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  resources :sessions, :only => [:new,:create]

  
  get 'signup' => 'users#new'
  match 'signup_confirmation/:token' => 'users#signup_confirmation', :as => :signup_confirmation
  resources :users, :only => [:show,:new,:create] do
    collection do
      get :signup_confirmation
    end
  end

  resources :locales, :only => :index
  resources :translations, :only => [:index,:create] do
    collection do
      put 'update_multiple'
    end
  end

  resources :words, :only => [:show,:index,:new,:create,:edit,:update]
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

  resources :categories, :only => [:show,:index,:create,:update,:destroy]

  get 'welcome' => 'poems#index'
  root :to => 'poems#index'

  resources :sources, :only => [:show,:index,:create,:update]
end
