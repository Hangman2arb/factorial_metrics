Rails.application.routes.draw do
  root to: 'metrics#index'

  resources :metrics, only: [:index, :create] do
    collection do
      get :data
    end
  end

  namespace :api do
    namespace :v1 do
      resources :metrics, only: [:index, :create]
    end
  end
end
