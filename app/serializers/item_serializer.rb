class ItemSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :unit_price,
             :merchant_id,
             :created_at,
             :updated_at

  def unit_price
    self.object.unit_price.to_f / 100
  end

end