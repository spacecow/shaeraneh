Shaeraneh::Application.routes.draw do
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
