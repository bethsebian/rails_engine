class Api::V1::Merchants::AnalysisController < ApplicationController
	respond_to :json

	def index
		@merchants = MerchantsHelper.analysis(params, request)
		respond_with @merchants
	end
end

