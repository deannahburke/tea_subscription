Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

customer1 = Customer.create!(first_name: "Deannah", last_name: "Burke", email: "dmb@gmail.com", address: "123 Bryant Street Denver CO 80211")
customer2 = Customer.create!(first_name: "Casey", last_name: "Pancakes", email: "pancakes@gmail.com", address: "456 Pancake Street Denver CO 80202")
customer3 = Customer.create!(first_name: "Sai", last_name: "Bean", email: "BeanIsQueen@gmail.com", address: "798 Bean Street Denver CO 80211")
tea1 = Tea.create!(title: "Green Ginger", description: "Spicy, sweet, medium caffeine content", temperature: 103.5, brewtime: "2 minutes")
tea2 = Tea.create!(title: "Lavender Chamomile", description: "Soothing, floral, caffeine free", temperature: 102.0, brewtime: "4 minutes")
tea3 = Tea.create!(title: "Cinnamon Chai", description: "Warm, spiced, medium caffeine content", temperature: 102.0, brewtime: "4 minutes")
tea4 = Tea.create!(title: "White Jasmine", description: "Soothing, floral", temperature: 102.0, brewtime: "4 minutes")
subscription1 = customer1.subscriptions.create!(title: "Weekly Green", price: 25.50, tea_id: tea1.id, status: 0, frequency: 0)
subscription2 = customer1.subscriptions.create!(title: "Monthly Chamomile", price: 41.75, tea_id: tea2.id, status: 1, frequency: 1)
subscription3 = customer1.subscriptions.create!(title: "Weekly Chai", price: 21.60, tea_id: tea3.id, status: 0, frequency: 0)
subscription4 = customer2.subscriptions.create!(title: "Weekly Herbal", price: 18.00, tea_id: tea4.id, status: 0, frequency: 0)
