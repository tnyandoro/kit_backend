# config/routes.rb
Rails.application.routes.draw do
  
  # --- PUBLIC ROUTES (For the React Admissions Form) ---
  namespace :api do
    post 'admissions/create', to: 'admissions#create'
    post 'admissions/organization', to: 'admissions#create_organization'
    get 'admissions/individuals', to: 'admissions#individuals' # For testing
  end

  # --- ADMIN ROUTES (For the Admin Dashboard) ---
  namespace :api do
    namespace :admin do
      # Auth
      post 'login', to: 'auth#login'

      # Dashboard Stats
      get 'dashboard/stats', to: 'dashboard#stats'

      # Students Management
      get 'students', to: 'students#index'
      get 'students/:id', to: 'students#show'
      patch 'students/:id/update_status', to: 'students#update_status'

      # Organizations Management
      get 'organizations', to: 'organizations#index'
      get 'organizations/:id', to: 'organizations#show'
      patch 'organizations/:id/update_status', to: 'organizations#update_status'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end