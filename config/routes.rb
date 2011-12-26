Shaeraneh::Application.routes.draw do
  resources :poems, :only => [:show,:index,:new,:create]
  root :to => 'welcome#index'
end
