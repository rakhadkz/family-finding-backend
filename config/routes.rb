Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      resources :auth do
        collection do
          post 'login'
          post 'signup'
          post 'forgot_password'
          post 'reset_password'
        end
      end

      resources :users do
        collection do
          get 'me' => 'users#show'
        end
      end

      namespace :admin do
        resources :users
      end
    end
  end
end
