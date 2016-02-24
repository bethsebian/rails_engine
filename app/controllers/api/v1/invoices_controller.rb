class Api::V1::InvoicesController < ApplicationController
	respond_to :json

	def index
		@invoices = Invoice.all
		respond_with @invoices
	end

	def show
		@invoice = InvoicesHelper.finder(params, request.env["rack.request.query_hash"])
		respond_with @invoice
	end
end

