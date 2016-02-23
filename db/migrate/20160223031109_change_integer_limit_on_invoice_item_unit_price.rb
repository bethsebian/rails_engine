class ChangeIntegerLimitOnInvoiceItemUnitPrice < ActiveRecord::Migration
  def change
    change_column :invoice_items, :unit_price, :integer, limit: 3
  end
end
