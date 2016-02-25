require 'rails_helper'

RSpec.describe "Invoice Relationships API" do
	attr_reader :invoice

	before(:each) do
		@invoice  = create(:invoice)
	end

  it 'sends a list of invoice transactions' do
		t_1, t_2, t_3 = create_list(:transaction, 3, invoice_id: invoice.id)

		get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_success
    expect(json.length).to eq(3)
		expect(json.first['id']).to eq(t_3.id)
    expect(json.first['invoice_id']).to eq(t_3.invoice_id)
    expect(json.first['credit_card_number']).to eq(t_3.credit_card_number.to_s)
		expect(json.first['result']).to eq(t_3.result)
		expect(json.last['id']).to eq(t_1.id)
	end

	it 'sends a list of invoice invoice-items' do
		ii_1, ii_2, ii_3 = create_list(:invoice_item, 3, invoice_id: invoice.id)

		get "/api/v1/invoices/#{invoice.id}/invoice_items"

		expect(response).to be_success
    expect(json.length).to eq(3)
		expect(json.first['id']).to eq(ii_3.id)
    expect(json.first['item_id']).to eq(ii_3.item_id)
    expect(json.first['quantity']).to eq(ii_3.quantity)
		expect(json.first['unit_price']).to eq((ii_3.unit_price.to_f/100).to_s)
		expect(json.last['id']).to eq(ii_1.id)
	end

	it 'sends a list of invoice items' do
		i_1, i_2, i_3 = create_list(:item, 3)
		ii_1, ii_2, ii_3 = create_list(:invoice_item, 3, item_id: i_1.id, invoice_id: invoice.id)

		get "/api/v1/invoices/#{invoice.id}/items"

		expect(response).to be_success
    expect(json.length).to eq(3)
		expect(json.first['id']).to eq(i_1.id)
    expect(json.first['name']).to eq(i_1.name)
    expect(json.first['description']).to eq(i_1.description)
		expect(json.first['unit_price']).to eq((i_1.unit_price.to_f/100).to_s)
		expect(json.first['merchant_id']).to eq(i_1.merchant_id)
		expect(json.last['id']).to eq(i_1.id)
	end

	it 'sends the invoice customer' do
		customer = create(:customer)
		invoice = create(:invoice, customer_id: customer.id)

		get "/api/v1/invoices/#{invoice.id}/customer"

		expect(response).to be_success
		expect(json['id']).to eq(customer.id)
    expect(json['first_name']).to eq(customer.first_name)
    expect(json['last_name']).to eq(customer.last_name)
	end

	it 'sends a list of merchant invoices' do
		merchant = create(:merchant)
		invoice = create(:invoice, merchant_id: merchant.id)

		get "/api/v1/invoices/#{invoice.id}/merchant"
		expect(response).to be_success
		expect(json['id']).to eq(merchant.id)
    expect(json['name']).to eq(merchant.name)
	end
end
