module MerchantsHelper
	def self.finder(params, query_hash)
		deslug_query(query_hash)

		if query_hash.present? && params[:id] == "find"
			Merchant.find_by(query_hash)
		elsif query_hash.present? && params[:id] == "find_all"
			Merchant.where(query_hash)
		elsif params[:id] == "random"
			Merchant.order("RANDOM()").first
		else
			Merchant.find(params[:id])
		end
	end

	def self.deslug_query(query_hash)
		if query_hash.present?
			query_hash[query_hash.keys[0]] = query_hash.values[0].gsub(/-/, " ")
		end
	end

	def self.analysis(params, request)
		type = request.env["PATH_INFO"].split('/').last
		qty = params["quantity"]
		
	end
end