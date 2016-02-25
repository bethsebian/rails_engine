class Transaction < ActiveRecord::Base
	default_scope { order('id DESC') }

	belongs_to :invoice
end
