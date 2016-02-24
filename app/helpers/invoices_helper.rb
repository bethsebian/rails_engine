module InvoicesHelper
	def self.finder(params, query_hash)
		if query_hash.present? && params[:id] == "find"
			Invoice.find_by(query_hash)
		elsif query_hash.present? && params[:id] == "find_all"
			Invoice.where(query_hash)
		elsif params[:id] == "random"
			Invoice.order("RANDOM()").first
		else
			Invoice.find(params[:id])
		end
	end
end