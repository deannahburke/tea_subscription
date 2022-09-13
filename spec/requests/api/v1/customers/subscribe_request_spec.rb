require 'rails_helper'

RSpec.describe 'create subscription endpoint' do
  context 'happy path' do
    it 'creates a customer subscription' do
      customer = Customer.create!(first_name: "Deannah", last_name: "Burke", email: "dmb@gmail.com", address: "123 Bryant Street Denver CO 80211")
      tea = Tea.create!(title: "Green Ginger", description: "Spicy, sweet, medium caffeine content", temperature: 103.5, brewtime: "2 minutes")
      subscription_params =
        {
          title: "Weekly Green",
          price: 25.50,
          tea_id: tea.id,
          frequency: 0
        }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/customers/#{customer.id}/subscribe", headers: headers, params: JSON.generate(subscription_params)

      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(201)
      expect(subscription).to have_key(:data)
      expect(subscription[:data]).to have_key(:type)
      expect(subscription[:data]).to have_key(:id)
      expect(subscription[:data]).to have_key(:attributes)
      expect(subscription[:data][:type]).to eq("subscriptions")
      expect(subscription[:data][:attributes]).to have_key(:title)
      expect(subscription[:data][:attributes][:title]).to be_a(String)
      expect(subscription[:data][:attributes]).to have_key(:price)
      expect(subscription[:data][:attributes][:price]).to be_a(Float)
      expect(subscription[:data][:attributes]).to have_key(:status)
      expect(subscription[:data][:attributes][:status]).to be_a(String)
      expect(subscription[:data][:attributes]).to have_key(:frequency)
      expect(subscription[:data][:attributes][:frequency]).to be_a(String)
    end
  end

  context 'sad path' do
    it 'will not create subscription without all params' do
      customer = Customer.create!(first_name: "Deannah", last_name: "Burke", email: "dmb@gmail.com", address: "123 Bryant Street Denver CO 80211")
      tea = Tea.create!(title: "Green Ginger", description: "Spicy, sweet, medium caffeine content", temperature: 103.5, brewtime: "2 minutes")
      subscription_params =
        {
          title: "Weekly Green",
          price: 25.50,
          tea_id: tea.id,
          frequency: ""
        }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/customers/#{customer.id}/subscribe", headers: headers, params: JSON.generate(subscription_params)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Frequency can't be blank")
    end
  end
end
