class Api::V1::CustomersController < ApplicationController
	respond_to :json

	def index
		@customers = Customer.all
		respond_with @customers
	end

	def show
		@customer = CustomersHelper.finder(params, request.env["rack.request.query_hash"])
		respond_with @customer
	end
end

