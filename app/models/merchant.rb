class Merchant < ActiveRecord::Base
	default_scope { order('id DESC') }
	has_many :invoices
	has_many :invoice_items, through: :invoices

	def total_revenue
		invoices.successful_transactions.sum("unit_price * quantity").to_f
	end
end
