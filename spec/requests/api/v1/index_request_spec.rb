require 'rails_helper'

RSpec.describe 'get all customer subscriptions endpoint' do
  context 'happy path' do
    it 'returns all customer subscriptions including cancelled subscriptions' do
      customer = Customer.create!(first_name: "Deannah", last_name: "Burke", email: "dmb@gmail.com", address: "123 Bryant Street Denver CO 80211")
      tea = Tea.create!(title: "Green Ginger", description: "Spicy, sweet, medium caffeine content", temperature: 103.5, brewtime: "2 minutes")
      tea2 = Tea.create!(title: "Lavender Chamomile", description: "Soothing, floral", temperature: 102.0, brewtime: "4 minutes")
      subscription1 = customer.subscriptions.create!(title: "Weekly Green", price: 25.50, tea_id: tea.id, frequency: 0)
      subscription2 = customer.subscriptions.create!(title: "Monthly Chamomile", price: 25.50, tea_id: tea2.id, status: 1, frequency: 1)

      get "/api/v1/customers/#{customer.id}/subscriptions"

      index = JSON.parse(response.body, symbolize_names: true)

      expect(index).to have_key(:data)
      expect(index[:data][:type]).to eq("customers")
      expect(index[:data][:id]).to eq(customer.id)
      expect(index[:data][:attributes]).to have_key(:subscriptions)
      expect(index[:data][:attributes][:subscriptions]).to be_a(Array)
      expect(index[:data][:attributes][:subscriptions].count).to eq(2)
      expect(index[:data][:attributes][:subscriptions][0]).to have_key(:title)
      expect(index[:data][:attributes][:subscriptions][0]).to have_key(:price)
      expect(index[:data][:attributes][:subscriptions][0]).to have_key(:status)
      expect(index[:data][:attributes][:subscriptions][0]).to have_key(:frequency)
      expect(index[:data][:attributes][:subscriptions][0][:status]).to eq("active")
      expect(index[:data][:attributes][:subscriptions][0][:frequency]).to eq("weekly")
      expect(index[:data][:attributes][:subscriptions][1]).to have_key(:title)
      expect(index[:data][:attributes][:subscriptions][1]).to have_key(:price)
      expect(index[:data][:attributes][:subscriptions][1]).to have_key(:status)
      expect(index[:data][:attributes][:subscriptions][1]).to have_key(:frequency)
      expect(index[:data][:attributes][:subscriptions][1][:status]).to eq("cancelled")
      expect(index[:data][:attributes][:subscriptions][1][:frequency]).to eq("monthly")
    end

    it 'will return message if customer has no subscriptions' do
      customer = Customer.create!(first_name: "Deannah", last_name: "Burke", email: "dmb@gmail.com", address: "123 Bryant Street Denver CO 80211")

      get "/api/v1/customers/#{customer.id}/subscriptions"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(body).to have_key(:message)
      expect(body[:message]).to eq("This customer has no subscriptions")
    end
  end

  context 'sad path' do
    it 'will return error if customer id cannot be found' do
      get "/api/v1/customers/4/subscriptions"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      expect(body).to have_key(:error)
      expect(body[:error]).to eq("Invalid customer ID")
    end
  end
end
