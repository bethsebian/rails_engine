require 'rails_helper'

RSpec.describe "InvoiceItem Relationships API" do

	it 'returns the associated invoice of an invoice item' do
		invoice = create(:invoice)
		invoice_item = create(:invoice_item, invoice_id: invoice.id)

		get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

		expect(response).to be_success
		expect(json['id']).to eq(invoice.id)
    expect(json['customer_id']).to eq(invoice.customer_id)
		expect(json['merchant_id']).to eq(invoice.merchant_id)
		expect(json['status']).to eq(invoice.status)
	end

	it 'returns the associated item of an invoice item' do
		item = create(:item)
		invoice_item = create(:invoice_item, item_id: item.id)

		get "/api/v1/invoice_items/#{invoice_item.id}/item"

		expect(response).to be_success
		expect(json['id']).to eq(item.id)
    expect(json['name']).to eq(item.name)
		expect(json['description']).to eq(item.description)
		expect(json['unit_price']).to eq((item.unit_price.to_f/100).to_s)
		expect(json['merchant_id']).to eq(item.merchant_id)
	end
end