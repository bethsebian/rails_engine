class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :merchant_id
      t.string :status
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
