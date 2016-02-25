class Merchant < ActiveRecord::Base
	default_scope { order('id DESC') }
	has_many :invoices
	has_many :invoice_items, through: :invoices

	def total_revenue
		self.invoice_items.map { |ii| ii.total_cost }.reduce(:+)
	end
end
