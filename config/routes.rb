WalkMe::Application.routes.draw do
  resources :tasks


  resources :catalogs


  get "app/demo"

  mount StripeEvent::Engine => '/stripe'
  
  namespace :api do
    namespace :v1  do
      resources :tokens,:only => [:create, :destroy]
    end
  end

  get "content/silver"
  get "content/gold"
  get "content/platinum"  

  authenticated :user do
    root :to => 'home#index'
  end
  match "/" => redirect("/blog")
  
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
    #root :to => "devise/registrations#new"
    match '/request' =>"devise/registrations#new"
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations" }
  match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  resources :users, :only => [:show, :index] do
    get 'invite', :on => :member
  end
end