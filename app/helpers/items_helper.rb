module ItemsHelper
	def self.finder(params, query_hash)
		if query_hash.present? && params[:id] == "find"
			Item.find_by(query_hash)
		elsif query_hash.present? && params[:id] == "find_all"
			Item.where(query_hash)
		elsif params[:id] == "random"
			Item.order("RANDOM()").first
		else
			Item.find(params[:id])
		end
	end
end