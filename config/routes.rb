Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "loot_tables#index"

  resources :loot_tables do
    resources :loot_items
  end
  post "/loot_tables/:id/roll", to: 'loot_tables#roll', as: "loot_table_roll"
end
