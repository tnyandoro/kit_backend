Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # API Routes for Admissions
  namespace :api do
    post 'admissions/create', to: 'admissions#create'
    post 'admissions/organization', to: 'admissions#create_organization'

    get 'admissions/individuals', to: 'admissions#individuals'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end