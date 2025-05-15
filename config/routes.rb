Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :inspections, only: [ :index, :new, :create, :destroy ] do
    member do
      patch :toggle_active
    end
  end

  resources :sheets, only: [ :index ] do
    collection do
      post :sync_with_drive
    end
  end

  post "/slack/commands", to: "slack#commands"
  post "/slack/interactions", to: "slack#interactions"

  root "inspections#index"
end
