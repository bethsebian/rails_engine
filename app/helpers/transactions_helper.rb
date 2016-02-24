module TransactionsHelper
	def self.finder(params, query_hash)
		if query_hash.present? && params[:id] == "find"
			Transaction.find_by(query_hash)
		elsif query_hash.present? && params[:id] == "find_all"
			Transaction.where(query_hash)
		elsif params[:id] == "random"
			Transaction.order("RANDOM()").first
		else
			Transaction.find(params[:id])
		end
	end
end