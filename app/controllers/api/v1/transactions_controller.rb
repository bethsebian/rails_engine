class Api::V1::TransactionsController < ApplicationController
	respond_to :json

	def index
		@transactions = Transaction.all
		respond_with @transactions
	end

	def show
		@transaction = TransactionsHelper.finder(params, request.env["rack.request.query_hash"])
		respond_with @transaction
	end
end