Shaeraneh::Application.routes.draw do
  resources :poems
  root :to => 'poems#index'
end
