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

      resources :siblings do
        collection do
          post 'my' => 'siblings#get_siblings'
          post '' => 'siblings#create'
          delete ':id' => 'siblings#delete'
        end
      end

      resources :contacts
      
      resources :comments

      resources :findings

      namespace :super_admin do
        resources :organizations
        resources :admins
      end

      namespace :admin do
        resources :users
        resources :search_vectors
      end

    end
  end
end
