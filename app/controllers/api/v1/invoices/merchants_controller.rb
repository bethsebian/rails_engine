class Api::V1::Invoices::MerchantsController < ApplicationController
	respond_to :json

	def show
		@merchant = Merchant.find(Invoice.find(params["invoice_id"]).merchant_id)
		respond_with @merchant
	end
end

