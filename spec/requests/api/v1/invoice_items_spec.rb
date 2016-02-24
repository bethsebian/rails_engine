require 'rails_helper'

RSpec.describe "InvoiceItems API" do
  attr_reader :ii_1, :ii_2, :ii_3, :ii_4, :ii_5, :ii_6, :ii_7

  before(:each) do
		@ii_1 = create(:invoice_item, item_id: 1, invoice_id: 1, quantity: 1)
		@ii_2 = create(:invoice_item, item_id: 2, invoice_id: 1, quantity: 1)
		@ii_3 = create(:invoice_item, item_id: 3, invoice_id: 1, quantity: 1)
		@ii_4 = create(:invoice_item, item_id: 2, invoice_id: 2, quantity: 2)
		@ii_5 = create(:invoice_item, item_id: 3, invoice_id: 2, quantity: 1)
		@ii_6 = create(:invoice_item, item_id: 1, invoice_id: 3, quantity: 3)
		@ii_7 = create(:invoice_item, item_id: 3, invoice_id: 3, quantity: 2)
  end

  it 'sends a list of invoice items' do
    get '/api/v1/invoice_items.json'

    expect(response).to be_success
    expect(json.length).to eq(7)
    expect(json.last['item_id']).to eq(ii_7.item_id)
    expect(json.last['invoice_id']).to eq(ii_7.invoice_id)
    expect(json.last['quantity']).to eq(ii_7.quantity)
		expect(json.last['unit_price']).to eq((ii_7.unit_price.to_f/100).to_s)

  end

	it 'sends details on one invoice item when passed ID' do
		get "/api/v1/invoice_items/#{ii_2.id}.json"

		expect(response).to be_success
		expect(json['id']).to eq(ii_2.id)
    expect(json['item_id']).to eq(ii_2.item_id)
    expect(json['invoice_id']).to eq(ii_2.invoice_id)
    expect(json['quantity']).to eq(ii_2.quantity)
		expect(json['unit_price']).to eq((ii_2.unit_price.to_f/100).to_s)
	end

  it 'sends details on invoice item when passed ID as param' do
		get "/api/v1/invoice_items/find?id=#{ii_2.id}"

    expect(response).to be_success
		expect(json['id']).to eq(ii_2.id)
    expect(json['item_id']).to eq(ii_2.item_id)
    expect(json['invoice_id']).to eq(ii_2.invoice_id)
    expect(json['quantity']).to eq(ii_2.quantity)
		expect(json['unit_price']).to eq((ii_2.unit_price.to_f/100).to_s)
	end

  it 'sends details on first matching invoice when passed ITEM_ID as param' do
    get "/api/v1/invoice_items/find?item_id=#{ii_2.item_id}"

		expect(response).to be_success
		expect(json['id']).to eq(ii_2.id)
    expect(json['item_id']).to eq(ii_2.item_id)
    expect(json['invoice_id']).to eq(ii_2.invoice_id)
    expect(json['quantity']).to eq(ii_2.quantity)
		expect(json['unit_price']).to eq((ii_2.unit_price.to_f/100).to_s)
  end

	it 'sends details on all matching invoices when passed ITEM_ID as param' do
    get "/api/v1/invoice_items/find_all?item_id=#{ii_2.item_id}"

	  expect(response).to be_success
	  expect(json.length).to eq(2)
		expect(json.last['id']).to eq(ii_4.id)
  end

	it 'sends details on first matching invoice when passed INVOICE_ID as param' do
		get "/api/v1/invoice_items/find?invoice_id=#{ii_2.invoice_id}"

		expect(ii_2.invoice_id).to eq(ii_1.invoice_id)
		expect(response).to be_success
		expect(json['id']).to eq(ii_1.id)
		expect(json['item_id']).to eq(ii_1.item_id)
		expect(json['invoice_id']).to eq(ii_1.invoice_id)
		expect(json['quantity']).to eq(ii_1.quantity)
		expect(json['unit_price']).to eq((ii_1.unit_price.to_f/100).to_s)
	end

	it 'sends details on all matching invoices when passed INVOICE_ID as param' do
		get "/api/v1/invoice_items/find_all?invoice_id=#{ii_2.invoice_id}"

		expect(response).to be_success
		expect(json.length).to eq(3)
		expect(json.last['id']).to eq(ii_3.id)
	end

	it 'sends details on first matching invoice when passed QUANTITY as param' do
		get "/api/v1/invoice_items/find?quantity=#{ii_2.quantity}"

		expect(ii_2.quantity).to eq(ii_1.quantity)
		expect(response).to be_success
		expect(json['id']).to eq(ii_1.id)
		expect(json['item_id']).to eq(ii_1.item_id)
		expect(json['invoice_id']).to eq(ii_1.invoice_id)
		expect(json['quantity']).to eq(ii_1.quantity)
		expect(json['unit_price']).to eq((ii_1.unit_price.to_f/100).to_s)
	end

	it 'sends details on all matching invoices when passed QUANTITY as param' do
		get "/api/v1/invoice_items/find_all?quantity=#{ii_2.quantity}"

		expect(response).to be_success
		expect(json.length).to eq(4)
		expect(json.last['id']).to eq(ii_5.id)
	end

	it 'sends details on first matching invoice when passed UNIT_PRICE as param' do
		get "/api/v1/invoice_items/find?unit_price=#{(ii_2.unit_price.to_f/100).to_s}"

		expect(response).to be_success
		expect(json['id']).to eq(ii_2.id)
		expect(json['item_id']).to eq(ii_2.item_id)
		expect(json['invoice_id']).to eq(ii_2.invoice_id)
		expect(json['quantity']).to eq(ii_2.quantity)
		expect(json['unit_price']).to eq((ii_2.unit_price.to_f/100).to_s)
	end

	it 'sends details on all matching invoices when passed UNIT_PRICE as param' do
		get "/api/v1/invoice_items/find_all?unit_price=#{(ii_2.unit_price.to_f/100).to_s}"

		expect(response).to be_success
		expect(json.length).to eq(1)
		expect(json.last['id']).to eq(ii_2.id)
	end

  it 'sends details on random invoice when passed RANDOM' do
    get "/api/v1/invoice_items/random.json"

    ii_random = InvoiceItem.find(json['id'])

    expect(response).to be_success
		expect(json['item_id']).to eq(ii_random.item_id)
		expect(json['invoice_id']).to eq(ii_random.invoice_id)
		expect(json['quantity']).to eq(ii_random.quantity)
		expect(json['unit_price']).to eq((ii_random.unit_price.to_f/100).to_s)
  end
end