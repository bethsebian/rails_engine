module InvoiceItemsHelper
	def self.finder(params, query_hash)
		reformat_unit_price(query_hash)

		if query_hash.present? && params[:id] == "find"
			InvoiceItem.find_by(query_hash)
		elsif query_hash.present? && params[:id] == "find_all"
			InvoiceItem.where(query_hash)
		elsif params[:id] == "random"
			InvoiceItem.order("RANDOM()").first
		else
			InvoiceItem.find(params[:id])
		end
	end

	def self.reformat_unit_price(query_hash)
		if query_hash["unit_price"]
			query_hash["unit_price"] = (query_hash["unit_price"].to_f*100).to_i
		end
	end
end