class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

	def revenue
		(object.total_revenue.to_f / 100).to_s
	end
end
