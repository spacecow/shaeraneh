Shaeraneh::Application.routes.draw do
  resources :words, :only => [:index,:new]
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
