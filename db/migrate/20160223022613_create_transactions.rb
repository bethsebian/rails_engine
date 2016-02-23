class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.integer :credit_card_number
      t.string :result
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
