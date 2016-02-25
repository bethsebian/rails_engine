class Api::V1::Invoices::TransactionsController < ApplicationController
	respond_to :json

	def index
		@transactions = Transaction.where(invoice_id: params["invoice_id"])
		respond_with @transactions
	end
end

