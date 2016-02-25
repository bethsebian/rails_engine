class Merchant < ActiveRecord::Base
	default_scope { order('id DESC') }

	has_many :invoices
	has_many :invoice_items, through: :invoices
end
