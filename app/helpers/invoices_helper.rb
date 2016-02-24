module InvoicesHelper
	def self.finder(params, query_string)
		if query_string.present?
			Invoice.find_by(query_string.split("=").first.to_sym => query_string.split("=").last)
		else
			Invoice.find(params[:id])
		end
	end
end
