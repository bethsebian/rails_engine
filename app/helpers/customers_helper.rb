module CustomersHelper
	def self.finder(params, query_hash)
		deslug_query(query_hash)
		if query_hash.present? && params[:id] == "find"
			Customer.find_by(query_hash)
		elsif query_hash.present? && params[:id] == "find_all"
			Customer.where(query_hash)
		elsif params[:id] == "random"
			Customer.order("RANDOM()").first
		else
			Customer.find(params[:id])
		end
	end

	def self.deslug_query(query_hash)
		if query_hash.present?
			query_hash[query_hash.keys[0]] = query_hash.values[0].gsub(/-/, " ")
		end
	end
end