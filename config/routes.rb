Shaeraneh::Application.routes.draw do
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
