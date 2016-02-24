class Api::V1::ItemsController < ApplicationController
	respond_to :json

	def index
		@items = Item.all
		respond_with @items
	end

	def show
		@item = ItemsHelper.finder(params, request.env["rack.request.query_hash"])
		respond_with @item
	end
end

