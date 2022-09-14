require 'rails_helper'

RSpec.describe 'update subscription endpoint' do
  context 'happy path' do
    it 'updates a subscription to cancelled' do
      customer = Customer.create!(first_name: "Deannah", last_name: "Burke", email: "dmb@gmail.com", address: "123 Bryant Street Denver CO 80211")
      tea = Tea.create!(title: "Green Ginger", description: "Spicy, sweet, medium caffeine content", temperature: 103.5, brewtime: "2 minutes")
      subscription = customer.subscriptions.create!(title: "Weekly Green", price: 25.50, tea_id: tea.id, frequency: 0)
      cancellation_params =
        {
          subscription_id: subscription.id,
          status: "cancelled"
        }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/customers/#{customer.id}/cancel", headers: headers, params: JSON.generate(cancellation_params)

      cancellation = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(cancellation).to have_key(:data)
      expect(cancellation[:data]).to have_key(:type)
      expect(cancellation[:data]).to have_key(:id)
      expect(cancellation[:data]).to have_key(:attributes)
      expect(cancellation[:data][:type]).to eq("subscriptions")
      expect(cancellation[:data][:attributes]).to have_key(:title)
      expect(cancellation[:data][:attributes][:title]).to be_a(String)
      expect(cancellation[:data][:attributes]).to have_key(:price)
      expect(cancellation[:data][:attributes][:price]).to be_a(Float)
      expect(cancellation[:data][:attributes]).to have_key(:status)
      expect(cancellation[:data][:attributes][:status]).to be_a(String)
      expect(cancellation[:data][:attributes][:status]).to eq("cancelled")
      expect(cancellation[:data][:attributes]).to have_key(:frequency)
      expect(cancellation[:data][:attributes][:frequency]).to be_a(String)
    end
  end

  context 'sad path' do
    it 'will not update without required params' do
    customer = Customer.create!(first_name: "Deannah", last_name: "Burke", email: "dmb@gmail.com", address: "123 Bryant Street Denver CO 80211")
    tea = Tea.create!(title: "Green Ginger", description: "Spicy, sweet, medium caffeine content", temperature: 103.5, brewtime: "2 minutes")
    subscription = customer.subscriptions.create!(title: "Weekly Green", price: 25.50, tea_id: tea.id, frequency: 0)
    cancellation_params =
      {
        subscription_id: "",
        status: "cancelled"
      }
    headers = {"CONTENT_TYPE" => "application/json"}
    patch "/api/v1/customers/#{customer.id}/cancel", headers: headers, params: JSON.generate(cancellation_params)

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(body).to have_key(:error)
    expect(body[:error]).to eq("Cannot find subscription without ID")
  end
end 
end
