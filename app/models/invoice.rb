class Invoice < ActiveRecord::Base
	default_scope { order('id DESC') }

	has_many :invoice_items
	has_many :items, through: :invoice_items
	has_one :customer
	has_many :transactions
end
