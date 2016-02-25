class Api::V1::Merchants::RevenuesController < ApplicationController
	respond_to :json

	def show
		render json: Merchant.find(params[:merchant_id]),
					 serializer: ::MerchantRevenueSerializer
	end
end

