require 'rails_helper'

RSpec.describe "Invoice API" do
  attr_reader :i_1, :i_2, :i_3

  before(:each) do
    @i_1, @i_2, @i_3 = create_list(:invoice, 3)
  end

  it 'sends a list of invoices' do
    get '/api/v1/invoices.json'

    expect(response).to be_success
    expect(json.length).to eq(3)
    expect(json.last['customer_id']).to eq(i_3.customer_id)
    expect(json.last['merchant_id']).to eq(i_3.merchant_id)
    expect(json.last['status']).to eq(i_3.status)
  end

	it 'sends details on one invoice when passed ID' do
		get "/api/v1/invoices/#{i_2.id}.json"

		expect(response).to be_success
		expect(json["id"]).to eq(i_2.id)
    expect(json['customer_id']).to eq(i_2.customer_id)
    expect(json['merchant_id']).to eq(i_2.merchant_id)
    expect(json['status']).to eq(i_2.status)
	end

  it 'sends details on invoice when passed ID as param' do
		get "/api/v1/invoices/find?id=#{i_2.id}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
    expect(json['customer_id']).to eq(i_2.customer_id)
    expect(json['merchant_id']).to eq(i_2.merchant_id)
    expect(json['status']).to eq(i_2.status)
	end

  it 'sends details on invoice when passed CUSTOMER_ID as param' do
    get "/api/v1/invoices/find?customer_id=#{i_2.customer_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
    expect(json['customer_id']).to eq(i_2.customer_id)
    expect(json['merchant_id']).to eq(i_2.merchant_id)
    expect(json['status']).to eq(i_2.status)
  end

  it 'sends details on first matching invoice when passed CUSTOMER_ID as param' do
    i_4 = create(:invoice, customer_id: i_2.customer_id)
    get "/api/v1/invoices/find?customer_id=#{i_2.customer_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
    expect(json["id"]).to_not eq(i_4.id)
    expect(json['customer_id']).to eq(i_2.customer_id)
    expect(json['merchant_id']).to eq(i_2.merchant_id)
    expect(json['status']).to eq(i_2.status)
  end

  it 'sends details on invoice when passed MERCHANT_ID as param' do
    get "/api/v1/invoices/find?merchant_id=#{i_2.merchant_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
    expect(json['customer_id']).to eq(i_2.customer_id)
    expect(json['merchant_id']).to eq(i_2.merchant_id)
    expect(json['status']).to eq(i_2.status)
  end

  it 'sends details on first matching invoice when passed CUSTOMER_ID as param' do
    i_4 = create(:invoice, merchant_id: i_2.merchant_id)
    get "/api/v1/invoices/find?merchant_id=#{i_2.merchant_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
    expect(json["id"]).to_not eq(i_4.id)
    expect(json['customer_id']).to eq(i_2.customer_id)
    expect(json['merchant_id']).to eq(i_2.merchant_id)
    expect(json['status']).to eq(i_2.status)
  end

  it 'sends details on first matching invoice when passed STATUS as param' do
    get "/api/v1/invoices/find?status=#{i_2.status}"

    expect(i_1.status).to eq (i_2.status)
    expect(response).to be_success
    expect(json["id"]).to eq(i_1.id)
    expect(json["id"]).to_not eq(i_2.id)
    expect(json['customer_id']).to eq(i_1.customer_id)
    expect(json['merchant_id']).to eq(i_1.merchant_id)
    expect(json['status']).to eq(i_1.status)
  end

  it 'sends details on invoice when passed STATUS case-insensitive' do
    get "/api/v1/invoices/find?status=sHipped"

    expect(i_1.status).to eq (i_2.status)
    expect(response).to be_success
    expect(json["id"]).to eq(i_1.id)
  end

  it 'sends details on multiple invoices when passed STATUS' do
    i_4 = create(:invoice, status: "cancelled")
    get "/api/v1/invoices/find_all?status=#{i_1.status}"

    expect(response).to be_success
    expect(json.length).to eq(3)
    expect(json.last['customer_id']).to eq(i_3.customer_id)
    expect(json.last['merchant_id']).to eq(i_3.merchant_id)
    expect(json.last['status']).to eq(i_3.status)
  end

  it 'sends details on random invoice when passed RANDOM' do
    get "/api/v1/invoices/random.json"

    i_random = Invoice.find(json['id'])

    expect(response).to be_success
    expect(json['customer_id']).to eq(i_random.customer_id)
    expect(json['merchant_id']).to eq(i_random.merchant_id)
    expect(json['status']).to eq(i_random.status)
  end
end