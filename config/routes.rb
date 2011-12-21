Shaeraneh::Application.routes.draw do
  resources :letters, :only => :index
  root :to => 'welcome#index'
end
