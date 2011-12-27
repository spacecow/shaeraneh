Shaeraneh::Application.routes.draw do
  resources :poems, :only => [:show,:index,:new,:create,:destroy]
  root :to => 'poems#index'
end
