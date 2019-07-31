Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :athletes, only: [:index], path: 'olympians'
      resources :statistics, only: [:index], path: 'olympian_stats'
      resources :events, only: [:index] do
        get '/medalists', to: 'events#show'
      end
    end
  end
end
 