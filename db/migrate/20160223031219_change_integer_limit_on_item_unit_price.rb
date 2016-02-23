class ChangeIntegerLimitOnItemUnitPrice < ActiveRecord::Migration
  def change
    change_column :items, :unit_price, :integer, limit: 3
  end
end
