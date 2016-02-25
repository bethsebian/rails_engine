class Invoice < ActiveRecord::Base
	default_scope { order('id DESC') }
	scope :successful_transactions, -> { joins(:transactions, :invoice_items).where("result = 'success'") }
	has_many :invoice_items
	has_many :items, through: :invoice_items
	has_one :customer
	has_many :transactions

end
