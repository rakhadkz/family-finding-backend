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
          put '' => 'users#update'
          delete '' => 'users#destroy'
        end
      end

      resources :children

      resources :contacts
      
      resources :comments

      namespace :super_admin do
        resources :organizations
        resources :organization_admins
      end

      namespace :organization_admin do
        resources :users
      end

    end
  end
end
