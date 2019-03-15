Rails.application.routes.draw do
  namespace :tax do
    resources :vehicles, only: [:new, :create, :update, :show] do
      member do
        get :pay
      end
    end
  end
  resources :charges, :only => [:new, :create]
  root :to => "charges#new"
end
