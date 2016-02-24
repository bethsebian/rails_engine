class Api::V1::MerchantsController < ApplicationController
	respond_to :json

	def index
		@merchants = Merchant.all
		respond_with @merchants
	end

	def show
		@merchant = MerchantsHelper.finder(params, request.env["rack.request.query_hash"])
		respond_with @merchant
	end
end

