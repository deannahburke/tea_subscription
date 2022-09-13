class SubscriptionSerializer
  def self.new(subscription)
    {
      data: {
        type: "subscriptions",
        id: subscription.id,
        attributes: {
          "title": subscription.title,
          "price": subscription.price,
          "status": subscription.status,
          "frequency": subscription.frequency
        }
      }
    }
  end
end
