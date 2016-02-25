class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def unit_price
    (self.object.unit_price.to_f / 100).to_s
  end

	def revenue
		(object.total_revenue.to_f / 100).to_s
	end
end
