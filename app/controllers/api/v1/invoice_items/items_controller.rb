class Api::V1::InvoiceItems::ItemsController < ApplicationController
	respond_to :json

	def show
		@item = Item.find(InvoiceItem.find(params["invoice_item_id"]).item_id)
		respond_with @item
	end
end
