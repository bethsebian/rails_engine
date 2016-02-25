class Api::V1::Invoices::ItemsController < ApplicationController
	respond_to :json

	def index
		@items = Invoice.find(params["invoice_id"]).items
		respond_with @items
	end
end

