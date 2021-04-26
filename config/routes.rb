Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      get 'forecast', to: 'forecasts#show'
      get 'backgrounds', to: 'images#show'
      post 'users', to: 'users#create'
      post 'sessions', to: 'sessions#create'
      get 'salaries', to: 'salaries#index'
    end 
  end
end
