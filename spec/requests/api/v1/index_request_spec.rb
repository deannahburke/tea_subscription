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
      require "pry";binding.pry
      expect(index).to have_key(:data)
    end
  end
end
