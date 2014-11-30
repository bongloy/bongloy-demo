BongloyDemo::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resource :home, :only => :show

  resources :charges, :only => [:new, :create]

  get "dashboard", :to => "charges#new", :as => "user_root"
  root :to => "homes#show"
end
