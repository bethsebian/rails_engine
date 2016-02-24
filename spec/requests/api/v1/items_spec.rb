require 'rails_helper'

RSpec.describe "Items API" do
  attr_reader :i_1, :i_2, :i_3

  before(:each) do
		@i_1, @i_2, @i_3 = create_list(:item, 3)
  end

  it 'sends a list of items' do
    get '/api/v1/items.json'

    expect(response).to be_success
    expect(json.length).to eq(3)
    expect(json.last['name']).to eq(i_3.name)
    expect(json.last['description']).to eq(i_3.description)
    expect(json.last['unit_price']).to eq(i_3.unit_price)
		expect(json.last['merchant_id']).to eq(i_3.merchant_id)
  end

	it 'sends details on one item when passed ID' do
		get "/api/v1/items/#{i_2.id}.json"

		expect(response).to be_success
		expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
	end

  it 'sends details on item when passed ID as param' do
		get "/api/v1/items/find?id=#{i_2.id}"

    expect(response).to be_success
		expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
	end

	it 'sends details on transaction when passed NAME as param' do
		get "/api/v1/items/find?name=#{i_2.name}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
  end

  it 'sends details on first matching item when passed NAME as param' do
    i_4 = create(:item, name: "AaaBbbb")
		i_5 = create(:item, name: "AaaBbbb")
    get "/api/v1/items/find?name=#{i_4.name}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_4.id)
    expect(json["id"]).to_not eq(i_5.id)
		expect(json['name']).to eq(i_4.name)
    expect(json['description']).to eq(i_4.description)
    expect(json['unit_price']).to eq(i_4.unit_price)
		expect(json['merchant_id']).to eq(i_4.merchant_id)
  end

	it 'sends details on item when passed NAME as param (case-insensitive)' do
		get "/api/v1/items/find?name=#{i_2.name.upcase}"

		expect(response).to be_success
		expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
	end

	it 'sends details on all matching items when passed NAME as param' do
		i_4 = create(:item, name: i_2.name)
		get "/api/v1/items/find_all?name=#{i_2.name}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(i_4.id)
	end

	it 'sends details on transaction when passed DESCRIPTION as param' do
		get "/api/v1/items/find?description=#{i_2.description}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
  end

  it 'sends details on first matching item when passed DESCRIPTION as param' do
    i_4 = create(:item, description: "AaaBbbb")
		i_5 = create(:item, description: "AaaBbbb")
    get "/api/v1/items/find?description=#{i_4.description}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_4.id)
    expect(json["id"]).to_not eq(i_5.id)
		expect(json['name']).to eq(i_4.name)
    expect(json['description']).to eq(i_4.description)
    expect(json['unit_price']).to eq(i_4.unit_price)
		expect(json['merchant_id']).to eq(i_4.merchant_id)
  end

	it 'sends details on item when passed DESCRIPTION as param (case-insensitive)' do
		get "/api/v1/items/find?description=#{i_2.description.upcase}"

		expect(response).to be_success
		expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
	end

	it 'sends details on all matching items when passed DESCRIPTION as param' do
		i_4 = create(:item, description: i_2.description)
		get "/api/v1/items/find_all?description=#{i_2.description}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(i_4.id)
	end

	it 'sends details on matching item when passed DESCRIPTION with spaces as param' do
    i_4 = create(:item, description: "This is a description")
    get "/api/v1/items/find?description=#{i_4.description}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_4.id)
		expect(json['name']).to eq(i_4.name)
    expect(json['description']).to eq(i_4.description)
    expect(json['unit_price']).to eq(i_4.unit_price)
		expect(json['merchant_id']).to eq(i_4.merchant_id)
  end

	it 'sends details on transaction when passed UNIT_PRICE as param' do
		get "/api/v1/items/find?unit_price=#{i_2.unit_price}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
  end

  it 'sends details on first matching item when passed UNIT_PRICE as param' do
    i_4 = create(:item, unit_price: 101)
		i_5 = create(:item, unit_price: i_4.unit_price)
    get "/api/v1/items/find?unit_price=#{i_4.unit_price}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_4.id)
    expect(json["id"]).to_not eq(i_5.id)
		expect(json['name']).to eq(i_4.name)
    expect(json['description']).to eq(i_4.description)
    expect(json['unit_price']).to eq(i_4.unit_price)
		expect(json['merchant_id']).to eq(i_4.merchant_id)
  end

	it 'sends details on all matching items when passed UNIT_PRICE as param' do
		i_4 = create(:item, unit_price: i_2.unit_price)
		get "/api/v1/items/find_all?unit_price=#{i_2.unit_price}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(i_4.id)
	end

	it 'sends details on transaction when passed MERCHANT_ID as param' do
		get "/api/v1/items/find?merchant_id=#{i_2.merchant_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_2.id)
		expect(json['name']).to eq(i_2.name)
    expect(json['description']).to eq(i_2.description)
    expect(json['unit_price']).to eq(i_2.unit_price)
		expect(json['merchant_id']).to eq(i_2.merchant_id)
  end

  it 'sends details on first matching item when passed MERCHANT_ID as param' do
    i_4 = create(:item, merchant_id: 101)
		i_5 = create(:item, merchant_id: i_4.merchant_id)
    get "/api/v1/items/find?merchant_id=#{i_4.merchant_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(i_4.id)
    expect(json["id"]).to_not eq(i_5.id)
		expect(json['name']).to eq(i_4.name)
    expect(json['description']).to eq(i_4.description)
    expect(json['unit_price']).to eq(i_4.unit_price)
		expect(json['merchant_id']).to eq(i_4.merchant_id)
  end

	it 'sends details on all matching items when passed MERCHANT_ID as param' do
		i_4 = create(:item, merchant_id: i_2.merchant_id)
		get "/api/v1/items/find_all?merchant_id=#{i_2.merchant_id}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(i_4.id)
	end

	it 'sends details on random item when passed RANDOM' do
		get "/api/v1/items/random.json"

		i_random = Item.find(json['id'])

		expect(response).to be_success
		expect(json['name']).to eq(i_random.name)
    expect(json['description']).to eq(i_random.description)
    expect(json['unit_price']).to eq(i_random.unit_price)
		expect(json['merchant_id']).to eq(i_random.merchant_id)
	end
end