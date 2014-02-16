BongloyDemo::Application.routes.draw do
  resources :charges, :only => [:new, :create]
  root :to => "charges#new"
end
