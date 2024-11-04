Rails.application.routes.draw do
  resources :image_embeddings
  resources :image_tags

  resources :settings, only: [ :index ]
  namespace :settings do
    resources :tag_names
    resources :image_paths
  end

  resources :image_cores do
    collection do
      get "search"
      post "search_items"
      post "description_receiver"
      post "status_receiver"
    end
    member do
      post "generate_description"
      post "generate_stopper"
    end
  end

  # Root
  root "image_cores#index"

  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check
end
