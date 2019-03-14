Rails.application.routes.draw do
  namespace :tax do
    resources :vehicles
  end
  resources :charges, :only => [:new, :create]
  root :to => "charges#new"
end
