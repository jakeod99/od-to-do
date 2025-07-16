require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  mount Sidekiq::Web => "/sidekiq"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "dashboard#index"
  resources :tasks do
    post "assign/:assign_id", to: "tasks#assign", as: "assign"
    post "start", to: "tasks#start", as: "start"
    post "unstart", to: "tasks#unstart", as: "unstart"
    post "skip", to: "tasks#skip", as: "skip"
    post "complete", to: "tasks#complete", as: "complete"
    post "add_to_wave", to: "tasks#add_to_wave", as: "add_to_wave"
    post "remove_from_wave", to: "tasks#remove_from_wave", as: "remove_from_wave"
  end
  resources :waves, except: [ :destroy ]
  resources :recurring_task_templates
  resources :categories
  resources :groups
end
