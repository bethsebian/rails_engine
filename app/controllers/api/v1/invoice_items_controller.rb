class Api::V1::InvoiceItemsController < ApplicationController
	respond_to :json

	def index
		@invoice_items = InvoiceItem.all
		respond_with @invoice_items
	end

	def show
		@invoice_item = InvoiceItemsHelper.finder(params, request.env["rack.request.query_hash"])
		respond_with @invoice_item
	end
end

