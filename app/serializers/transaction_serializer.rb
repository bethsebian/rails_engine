class TransactionSerializer < ActiveModel::Serializer
  attributes :id,
             :invoice_id,
             :credit_card_number,
             :result,
             :created_at,
             :updated_at

  def credit_card_number
    self.object.credit_card_number.to_s
  end
end
