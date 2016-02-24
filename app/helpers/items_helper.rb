module ItemsHelper
	def self.finder(params, query_hash)
		deslug_query(query_hash)
		reformat_unit_price(query_hash)

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

	def self.deslug_query(query_hash)
		if query_hash.present?
			query_hash[query_hash.keys[0]] = query_hash.values[0].gsub(/-/, " ")
		end
	end

	def self.reformat_unit_price(query_hash)
		if query_hash["unit_price"]
			query_hash["unit_price"] = (query_hash["unit_price"].delete('.')).to_i
		end
	end
end