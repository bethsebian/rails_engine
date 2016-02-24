class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id,
             :item_id,
             :invoice_id,
             :quantity,
             :unit_price,
             :created_at,
             :updated_at

  def unit_price
    self.object.unit_price.to_f / 100
  end
end
