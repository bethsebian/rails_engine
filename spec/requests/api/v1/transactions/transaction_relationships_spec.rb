require 'rails_helper'

RSpec.describe "Transaction Relationships API" do

	it 'returns associated invoice of a transaction' do
		invoice = create(:invoice)
		transaction = create(:transaction, invoice_id: invoice.id)

		get "/api/v1/transactions/#{transaction.id}/invoice"

		expect(response).to be_success
		expect(json['id']).to eq(invoice.id)
		expect(json['status']).to eq(invoice.status)
	end
end