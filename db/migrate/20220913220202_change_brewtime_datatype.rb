class ChangeBrewtimeDatatype < ActiveRecord::Migration[7.0]
  def change
    change_column :teas, :brewtime, :string
  end
end
