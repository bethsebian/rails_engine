class InvoiceItem < ActiveRecord::Base
	default_scope { order('id DESC') }
	belongs_to :item
	belongs_to :invoice

	def total_cost
		quantity * unit_price
	end
end

