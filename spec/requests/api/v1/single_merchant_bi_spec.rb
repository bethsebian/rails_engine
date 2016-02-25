require 'rails_helper'

RSpec.describe "Single Merchants Business Intelligence API" do
	it 'returns the total revenue for one merchant' do
		m_1 = create(:merchant)
		i_1 = create(:invoice, merchant_id: m_1.id)
		ii_1 = create(:invoice_item, invoice_id: i_1.id, unit_price: 911, quantity: 1)
		ii_2 = create(:invoice_item, invoice_id: i_1.id, unit_price: 440, quantity: 2)
		i_2 = create(:invoice, merchant_id: m_1.id)
		ii_3 = create(:invoice_item, invoice_id: i_2.id, unit_price: 470, quantity: 8)

		get "/api/v1/merchants/#{m_1.id}/revenue"

		expect(response).to be_success
		expect(json.length).to eq(1)
		expect(json).to eq({"revenue" => "55.51"})
	end
end