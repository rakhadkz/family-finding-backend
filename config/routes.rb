Rails.application.routes.draw do
  mount GoodJob::Engine => 'jobs'
  
  post "sendgrid_webhook/:token", to: "sendgrid#webhook"
  post "authenticate_domain/:token", to: "sendgrid#authenticate_domain"
  post "twilio_webhook/:token", to: "twilio#webhook"
  get "available_phone_numbers/:token", to: "twilio#available_phone_numbers"
  post "choose_phone_number/:token", to: "twilio#choose_phone_number"

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
      resources :twilio_phone_numbers
      resources :sendgrid_domains

      resources :templates_sent do
        collection do
          get 'generate_pdf'
        end
      end

      resources :communication_templates do
        collection do
          post 'send_message_to_contact'
        end
      end

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
      resources :connection_attachments
      resources :connection_comments
      resources :findings
      resources :finding_attachments
      resources :user_organizations
      resources :family_searches
      resources :family_search_attachments
      resources :family_search_connections

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
