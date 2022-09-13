class Tea < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :temperature
  validates_presence_of :brewtime

  has_many :subscriptions
end
