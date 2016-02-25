class Api::V1::Items::InvoiceItemsController < ApplicationController
	respond_to :json

	def index
		@invoice_items = InvoiceItem.where(item_id: params["item_id"])
		respond_with @invoice_items
	end
end

