require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
	it "#index" do
		i_1, i_2, i_3 = create_list(:invoice, 3)

		get :index, format: :json

		json = JSON.parse(response.body)

		expect(response).to be_success
		expect(json.length).to eq(3)
		expect(json.last['customer_id']).to eq(i_3.customer_id)
		expect(json.last['merchant_id']).to eq(i_3.merchant_id)
		expect(json.last['status']).to eq(i_3.status)
	end
end