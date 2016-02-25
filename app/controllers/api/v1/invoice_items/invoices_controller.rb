class Api::V1::InvoiceItems::InvoicesController < ApplicationController
	respond_to :json

	def show
		@invoice = Invoice.find(InvoiceItem.find(params["invoice_item_id"]).invoice_id)
		respond_with @invoice
	end
end

