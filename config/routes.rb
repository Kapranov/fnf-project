=begin
 Author: Andrey Zhuk
 Copyright (C) 2015 Zettheme. All Rights Reserved. https://zettheme.com
 Support:  support@zettheme.com
=end
Rails.application.routes.draw do
  
  get 'welcome/index'
  root to: "catalog/welcome#index"
  
  namespace :account do
    # resources after registration on devise add user first_name, last_name ... select role etc...
    resources :steps, only: [:show, :update]
    # resources manufacturer registration company, trademark, product etc...
    resources :manufacturer_steps, only: [:show, :update]
    # resources distributor registration company etc...
    resources :distributor_steps, only: [:show, :update]
  end

  namespace :catalog do
    get "/" => "products#index"
    resources :trademarks, only: [:index, :show]
    resources :companies, only: [:index, :show]
    # resources :categories, only: [:index, :show] do
    #   resources :products, only: [:index, :show] do
    #     member do
    #       get :like
    #       get :unlike
    #     end
    #   end
    # end
    
    resources :categories, only: [:index, :show]
    resources :products, only: [:index, :show] do
      member do
        put :like
        put :unlike
        put :favorite
        put :unfavorite
      end
    end
  resources :customers, only: [:index, :show] do
      member do
        put :follow
        put :unfollow
      end
    end
  end
  
  namespace :administration do
    get "/" => "dashboard#index"
    resources :orders do
      collection do
        post :search
      end
      member do
        post :accept
        post :reject
        post :ship
        get :despatch_note
      end
    end

    resources :trademarks, only: [:index, :show, :edit, :update]
    #match 'roles/index', to: 'roles#index', as: :roles, via: 'get'
    resources :customers, only: [:index, :show, :edit, :update] do
      collection do
        get :manufacturers
        get :distributors
        get :simple_customers
        get :all
      end
    end
    resources :employees, only: [:index, :show, :edit, :update] do
      collection do
        get :administrators
        get :moderators
        get :operators
        get :all
      end
    end
    resources :users
    resources :companies, only: [:index, :show, :edit, :update] do
      collection do
        get :published#, path: "/states/published"
        get :pending
        get :editing
        get :denied
        get :trashed
        get :removed
      end
    end
    scope "/stadistics" do
      resources :activities
    end
    scope "/catalog" do
      resources :categories
      resources :products, only: [:index, :show, :edit, :update] do
         collection do
          match 'search' => 'products#search', via: [:get, :post], as: :search
        end
      end
    end

    scope "/account" do

      match 'dashboard',  to: 'dashboard#index', as: :dashboard, via: [:get] 
      match 'profile', to: 'account#profile', as: :profile, via: 'get'

    end
    scope "/administration" do
      #match 'employees/list', to: 'employees#index', as: :employees, via: 'get'
      # TheRoleManagementPanel::Routes.mixin(self)
      resources :roles
      resources :activities
    end
  end

  #scope :account do
 
    resources :users do
      member do
        put :follow
        put :unfollow
      end
    end

    resources :product_images
    resources :companies
    resources :trademarks
    resources :categories, only: [:index, :show] do
      member do
        get :get_subcategories, defaults: { format: "js" }
      end
    end
    resources :subcategories
    resources :products

 
    resources :orders do
      collection do
        post :search
      end
      member do
        post :accept
        post :reject
        post :ship
        get :despatch_note
      end
    end
    
    scope "/account" do
      get 'dashboard',  to: 'dashboard#index', as: :dashboard
      get 'profile', to: 'account#profile', as: :profile
      match 'profile/update', to: 'account#update_profile', as: :update_profile, via: [:patch, :put] 
      get 'profile/edit', to: 'account#edit_profile', as: :edit_profile
      match 'my_favorite_products', to: 'account#my_favorite_products', as: :my_favorite_products, via: 'get'
    end
     
    #TheRoleManagementPanel::Routes.mixin(self)
    #devise_for :users, :path => '', controllers: {registrations: 'users/registrations'}
    
  #end

  devise_for :users, :path => '', controllers: { registrations: "registrations" }
  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
end
