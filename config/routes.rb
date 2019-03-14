Rails.application.routes.draw do
  namespace :tax do
    resources :vehicles, only: [:new, :create, :edit, :update, :show]
  end
  resources :charges, :only => [:new, :create]
  root :to => "charges#new"
end
