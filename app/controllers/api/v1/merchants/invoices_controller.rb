class Api::V1::Merchants::InvoicesController < ApplicationController
	respond_to :json

	def index
		@invoices = Invoice.where(merchant_id: params["merchant_id"])
		respond_with @invoices
	end
end

