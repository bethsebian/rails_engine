class Api::V1::Invoices::CustomersController < ApplicationController
	respond_to :json

	def show
		@customer = Customer.find(Invoice.find(params["invoice_id"]).customer_id)
		respond_with @customer
	end
end

