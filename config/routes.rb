# frozen_string_literal: true

Jets.application.routes.draw do
  resources :guest_authentications, only: :create

  namespace :api do
    resources :reservations, only: %i[index show create delete]
    resource :user, only: %i[show update]
    resources :households, only: %i[show create update delete]
    # resources :profiles, only: :index
    resources :profiles do
      collection do
        get 'user_data', to: "profiles#user_data"
        get 'user_address', to: "profiles#user_address"
        get 'user_contact_details', to: "profiles#user_contact_details"
        get 'user_vehicle_details', to: "profiles#user_vehicle_details"
        put 'update_user_data',    to: "profiles#update_user_data"
        put 'update_user_address', to: "profiles#update_user_data"
        put 'update_user_contact', to: "profiles#update_user_data"
        put 'update_user_vehicle', to: "profiles#update_user_data"
      end
    end
  end

  post 'auth_callbacks/facebook'
  post 'twilio/sms'
  post 'twilio/email'

  root 'jets/public#show'

  # The jets/public#show controller can serve static utf8
  # content out of the public folder.
  # Note, as part of the deploy process Jets uploads
  # files in the public folder to s3
  # and serves them out of s3 directly.
  # S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any '*catchall', to: 'jets/public#show'
end