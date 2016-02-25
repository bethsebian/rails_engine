class Api::V1::Customers::TransactionsController < ApplicationController
	respond_to :json

	def index
		@transactions = Transaction.where(invoice_id: Invoice.where(customer_id: params["customer_id"]))
		respond_with @transactions
	end
end