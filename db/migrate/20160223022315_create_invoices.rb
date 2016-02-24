class CreateInvoices < ActiveRecord::Migration
  def change
    enable_extension("citext")
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :merchant_id
      t.citext :status
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
