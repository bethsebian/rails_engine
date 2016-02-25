class Api::V1::Items::MerchantsController < ApplicationController
	respond_to :json

	def show
		@merchant = Merchant.find(Item.find(params["item_id"]).merchant_id)
		respond_with @merchant
	end
end

