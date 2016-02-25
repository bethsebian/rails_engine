class Item < ActiveRecord::Base
	default_scope { order('id DESC') }

	has_many :invoice_items
end
