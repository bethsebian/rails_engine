

require 'rails_helper'

RSpec.describe "Merchant Relationships API" do
  attr_reader :m_1, :in_1, :in_2, :it_1, :it_2

  before(:each) do
		@m_1  = create(:merchant)
    @in_1 = create(:invoice, merchant_id: m_1.id)
    @in_2 = create(:invoice, merchant_id: m_1.id)
    @it_1 = create(:item, merchant_id: m_1.id)
    @it_2 = create(:item, merchant_id: m_1.id)
  end

  it 'sends a list of merchant items' do
    get "/api/v1/merchants/#{m_1.id}/items.json"

    expect(response).to be_success
    expect(json.length).to eq(2)
    expect(json.first['id']).to eq(it_2.id)
    expect(json.first['name']).to eq(it_2.name)
		expect(json.last['id']).to eq(it_1.id)
    expect(json.last['description']).to eq(it_1.description)
  end
  #
	it 'sends a list of merchant invoices' do
		get "/api/v1/merchants/#{m_1.id}/invoices.json"

    expect(response).to be_success
    expect(json.length).to eq(2)
    expect(json.first['id']).to eq(in_2.id)
    expect(json.first['customer_id']).to eq(in_2.customer_id)
		expect(json.last['id']).to eq(in_1.id)
    expect(json.last['merchant_id']).to eq(in_1.merchant_id)
	end
end






GET /api/v1/invoice_items/:id/invoice returns the associated invoice
GET /api/v1/invoice_items/:id/item returns the associated item