require 'rails_helper'

RSpec.describe "Item Relationships API" do
	# attr_reader :invoice
	#
	# before(:each) do
	# 	@invoice  = create(:invoice)
	# end

	it 'returns a collection of invoice items associated with the item' do
		item = create(:item)
		invoice_1, invoice_2 = create_list(:invoice, 2)
		ii_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id)
		ii_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id)

		get "/api/v1/items/#{item.id}/invoice_items"

		expect(response).to be_success
    expect(json.length).to eq(2)
		expect(json.first['id']).to eq(ii_2.id)
		expect(json.last['id']).to eq(ii_1.id)
	end

	it "returns merchant associated with the merchant" do
		merchant = create(:merchant)
		item = create(:item, merchant_id: merchant.id)

		get "/api/v1/items/#{item.id}/merchant"

		expect(response).to be_success
		expect(json['name']).to eq(merchant.name)
	end
end