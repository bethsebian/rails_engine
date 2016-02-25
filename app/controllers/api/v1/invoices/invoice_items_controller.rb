class Api::V1::Invoices::InvoiceItemsController < ApplicationController
	respond_to :json

	def index
		@invoice_items = InvoiceItem.where(invoice_id: params["invoice_id"])
		respond_with @invoice_items
	end
end

