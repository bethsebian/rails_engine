class Api::V1::Transactions::InvoicesController < ApplicationController
	respond_to :json

	def show
		@invoice = Invoice.find(Transaction.find(params["transaction_id"]).invoice_id)
		respond_with @invoice
	end
end

