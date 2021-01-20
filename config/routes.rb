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

      resources :action_items

      resources :attachments

      resources :children

      resources :child_attachments

      resources :child_contacts

      resources :child_tree_contacts

      resources :communication_templates

      resources :siblingships

      resources :user_children do
        collection do
          get '' => 'user_children#index'
          post '' => 'user_children#create'
          put '' => 'user_children#update'
        end
      end

      resources :contacts
      
      resources :comments

      resources :comment_attachments

      resources :findings

      resources :finding_attachments

      resources :user_organizations

      namespace :super_admin do
        resources :organizations
        resources :admins
      end

      namespace :admin do
        resources :users
        resources :search_vectors
      end

      devise_for :users

    end
  end
end
