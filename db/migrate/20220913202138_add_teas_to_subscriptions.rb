class AddTeasToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :subscriptions, :tea, null: false, foreign_key: true
  end
end
