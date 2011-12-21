Shaeraneh::Application.routes.draw do
  resources :letters, :only => [:index,:new,:create]
  root :to => 'welcome#index'
end
