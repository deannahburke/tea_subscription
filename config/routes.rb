Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/customers/:customer_id/subscribe', to: 'subscriptions#create'
    end
  end
end
