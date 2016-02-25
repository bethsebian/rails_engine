require 'rails_helper'

RSpec.describe "Invoice Relationships API" do
  it 'sends a list of invoice transactions' do
		invoice = create(:invoice)
		t_1, t_2, t_3 = create_list(:transaction, 3, invoice_id: invoice.id)

		get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_success
    expect(json.length).to eq(3)
		expect(json.first['id']).to eq(t_3.id)
    expect(json.first['invoice_id']).to eq(t_3.invoice_id)
    expect(json.first['credit_card_number']).to eq(t_3.credit_card_number)
		expect(json.first['result']).to eq(t_3.result)
		expect(json.last['id']).to eq(it_1.id)
	end

	# it 'sends a list of merchant invoices' do
	# 	get "/api/v1/invoices/:id/transactions"
	#
	# end
	#
	# it 'sends a list of merchant invoices' do
	# 	/api/v1/invoices/:id/invoice_items
	# 	get "/api/v1/invoices/:id/transactions"
	# 	get "/api/v1/merchants/#{m_1.id}/invoices.json"
	# end
	# it 'sends a list of merchant invoices' do
	# 	/api/v1/invoices/:id/items
	# 	get "/api/v1/invoices/:id/transactions"
	# 	get "/api/v1/merchants/#{m_1.id}/invoices.json"
	# end
	# it 'sends a list of merchant invoices' do
	# 	/api/v1/invoices/:id/customer
	# 	get "/api/v1/invoices/:id/transactions"
	# 	get "/api/v1/merchants/#{m_1.id}/invoices.json"
	# end
	#
	# it 'sends a list of merchant invoices' do
	# /api/v1/invoices/:id/merchant
	# 	get "/api/v1/invoices/:id/transactions"
	# 	get "/api/v1/merchants/#{m_1.id}/invoices.json"
	# end
	#
end
