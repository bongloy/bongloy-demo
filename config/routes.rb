Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :charges, :only => [:new, :create]
  resource :checkout_configuration, :only => [:create]
  resource :checkout, :only => [:show]
  root :to => "charges#new"
end
