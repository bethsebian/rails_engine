require 'rails_helper'

RSpec.describe "Customer API" do
  attr_reader :c_1, :c_2, :c_3

  before(:each) do
		@c_1, @c_2, @c_3 = create_list(:customer, 3)
  end

  it 'sends a list of customers' do
    get '/api/v1/customers.json'

    expect(response).to be_success
    expect(json.length).to eq(3)
    expect(json.last['first_name']).to eq(c_3.first_name)
    expect(json.last['last_name']).to eq(c_3.last_name)
  end

	it 'sends details on one customer when passed ID' do
		get "/api/v1/customers/#{c_2.id}.json"

		expect(response).to be_success
		expect(json["id"]).to eq(c_2.id)
    expect(json['first_name']).to eq(c_2.first_name)
    expect(json['last_name']).to eq(c_2.last_name)
	end

  it 'sends details on customer when passed ID as param' do
		get "/api/v1/customers/find?id=#{c_2.id}"

    expect(response).to be_success
    expect(json["id"]).to eq(c_2.id)
    expect(json['first_name']).to eq(c_2.first_name)
    expect(json['last_name']).to eq(c_2.last_name)
	end

  it 'sends details on customer when passed FIRST_NAME as param' do
    get "/api/v1/customers/find?first_name=#{c_2.first_name}"

    expect(response).to be_success
    expect(json["id"]).to eq(c_2.id)
    expect(json['first_name']).to eq(c_2.first_name)
    expect(json['last_name']).to eq(c_2.last_name)
  end

  it 'sends details on first matching invoice when passed FIRST_NAME as param' do
    c_4 = create(:customer, first_name: c_2.first_name)
    get "/api/v1/customers/find?first_name=#{c_2.first_name}"

    expect(response).to be_success
    expect(json["id"]).to eq(c_2.id)
    expect(json["id"]).to_not eq(c_4.id)
    expect(json['first_name']).to eq(c_2.first_name)
    expect(json['last_name']).to eq(c_2.last_name)
  end

	# it 'sends details on customer when passed FIRST_NAME as param (case-insensitive)' do
	# 	get "/api/v1/customers/find?first_name=#{c_2.first_name.upcase}"
	#
	# 	expect(response).to be_success
	# 	expect(json["id"]).to eq(c_2.id)
	# 	expect(json['first_name']).to eq(c_2.first_name)
	# 	expect(json['last_name']).to eq(c_2.last_name)
	# end

	it 'sends details on customer when passed LAST_NAME as param' do
    get "/api/v1/customers/find?last_name=#{c_2.last_name}"

    expect(response).to be_success
    expect(json["id"]).to eq(c_2.id)
    expect(json['first_name']).to eq(c_2.first_name)
    expect(json['last_name']).to eq(c_2.last_name)
  end

  it 'sends details on first matching invoice when passed LAST_NAME as param' do
    c_4 = create(:customer, last_name: c_2.last_name)
    get "/api/v1/customers/find?last_name=#{c_2.last_name}"

    expect(response).to be_success
    expect(json["id"]).to eq(c_2.id)
    expect(json["id"]).to_not eq(c_4.id)
    expect(json['first_name']).to eq(c_2.first_name)
    expect(json['last_name']).to eq(c_2.last_name)
  end

	# it 'sends details on customer when passed LAST_NAME as param (case-insensitive)' do
	# 	get "/api/v1/customers/find?last_name=#{c_2.last_name.upcase}"
	#
	# 	expect(response).to be_success
	# 	expect(json["id"]).to eq(c_2.id)
	# 	expect(json['first_name']).to eq(c_2.first_name)
	# 	expect(json['last_name']).to eq(c_2.last_name)
	# end



  # it 'sends details on random invoice when passed RANDOM' do
  #   get "/api/v1/invoices/random.json"
	#
  #   i_random = Invoice.find(json['id'])
	#
  #   expect(response).to be_success
  #   expect(json['customer_id']).to eq(i_random.customer_id)
  #   expect(json['merchant_id']).to eq(i_random.merchant_id)
  #   expect(json['status']).to eq(i_random.status)
  # end
end