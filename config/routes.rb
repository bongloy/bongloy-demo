BongloyDemo::Application.routes.draw do
  devise_for :users, :skip => [:sessions], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  as :user do
    delete '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resource :home, :only => :show

  resources :charges, :only => [:new, :create, :index]
  root :to => "homes#show"
end
