Rails.application.routes.draw do
  resources :image_embeddings
  resources :image_tags
  resources :tag_names
  resources :image_paths

  # Configuring resources for 'image_cores' with custom collection route
  get "search", to: "image_cores#search"

  resources :image_cores do
    collection do
      post "search_items"
    end
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "image_cores#index"
end
