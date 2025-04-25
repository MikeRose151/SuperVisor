Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :inspections, only: [:index, :new, :create]

  resources :sheets, only: [:index] do
    collection do
      post :sync_with_drive
    end
  end

  post "/slack/trigger_inspection", to: "slack#trigger_inspection"

  root "inspections#index"
end
