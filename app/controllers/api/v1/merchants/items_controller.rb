class Api::V1::Merchants::ItemsController < ApplicationController
	respond_to :json

	def index
		@items = Item.where(merchant_id: params["merchant_id"])
		respond_with @items
	end
end

