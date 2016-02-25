require 'rails_helper'

RSpec.describe "Customer Relationships API" do

	it 'returns associated invoices of a customer' do
		customer = create(:customer)
		i_1, i_2, i_3 = create_list(:invoice, 3, customer_id: customer.id)

		get "/api/v1/customers/#{customer.id}/invoices"

		expect(response).to be_success
		expect(json.length).to eq(3)
		expect(json.last['id']).to eq(i_1.id)
		expect(json.last['status']).to eq(i_1.status)
	end

	it 'returns associated transaction of a customer' do
		customer = create(:customer)
		i_1, i_2 = create_list(:invoice, 2, customer_id: customer.id)
		t_1 = create(:transaction, invoice_id: i_1.id)
		t_2 = create(:transaction, invoice_id: i_1.id)
		t_3 = create(:transaction, invoice_id: i_2.id)

		get "/api/v1/customers/#{customer.id}/transactions"

		expect(response).to be_success
		expect(json.length).to eq(3)
		expect(json.last['id']).to eq(t_1.id)
		expect(json.last['result']).to eq(t_1.result)
	end
end
