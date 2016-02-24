module MerchantsHelper
	def self.finder(params, query_hash)
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
end