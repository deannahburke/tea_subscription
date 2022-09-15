Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/customers/:customer_id/subscribe', to: 'subscriptions#create'
      patch '/customers/:customer_id/subscriptions', to: 'subscriptions#update'
      get '/customers/:customer_id/subscriptions', to: 'subscriptions#index'
    end
  end
end
