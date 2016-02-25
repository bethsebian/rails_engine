require 'rails_helper'

RSpec.describe "Items API" do
  attr_reader :m_1, :m_2, :m_3

  before(:each) do
		@m_1, @m_2, @m_3 = create_list(:merchant, 3)
  end

  it 'sends a list of merchants' do
    get '/api/v1/merchants.json'

    expect(response).to be_success
    expect(json.length).to eq(3)
    expect(json.last['name']).to eq(m_1.name)
  end

	it 'sends details on one merchant when passed ID' do
		get "/api/v1/merchants/#{m_2.id}.json"

		expect(response).to be_success
		expect(json["id"]).to eq(m_2.id)
		expect(json['name']).to eq(m_2.name)
	end

  it 'sends details on merchant when passed ID as param' do
		get "/api/v1/merchants/find?id=#{m_2.id}"

		expect(response).to be_success
		expect(json["id"]).to eq(m_2.id)
		expect(json['name']).to eq(m_2.name)
	end

	it 'sends details on merchant when passed NAME as param' do
		get "/api/v1/merchants/find?name=#{m_2.name}"

		expect(response).to be_success
		expect(json["id"]).to eq(m_2.id)
		expect(json['name']).to eq(m_2.name)
  end

  it 'sends details on first matching merchant when passed NAME as param' do
    m_4 = create(:merchant, name: "AaaBbbb")
		m_5 = create(:merchant, name: "AaaBbbb")
    get "/api/v1/merchants/find?name=#{m_4.name}"

    expect(response).to be_success
    expect(json["id"]).to eq(m_5.id)
    expect(json["id"]).to_not eq(m_4.id)
		expect(json['name']).to eq(m_5.name)
  end

	it 'sends details on merchant when passed NAME as param (case-insensitive)' do
		get "/api/v1/merchants/find?name=#{m_2.name.upcase}"

		expect(response).to be_success
		expect(json["id"]).to eq(m_2.id)
		expect(json['name']).to eq(m_2.name)
	end

	it 'sends details on all matching merchants when passed NAME as param' do
		m_4 = create(:merchant, name: m_2.name)
		get "/api/v1/merchants/find_all?name=#{m_2.name}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(m_2.id)
	end

	it 'sends details on matching merchant when passed NAME with spaces as param' do
    m_4 = create(:merchant, name: "This is a spaced name")
    get "/api/v1/merchants/find?name=this-is-a-spaced-name"

		expect(response).to be_success
		expect(json["id"]).to eq(m_4.id)
		expect(json['name']).to eq(m_4.name)
  end

	it 'sends details on random merchant when passed RANDOM' do
		get "/api/v1/merchants/random.json"

		m_random = Merchant.find(json['id'])

		expect(response).to be_success
		expect(json["id"]).to eq(m_random.id)
		expect(json['name']).to eq(m_random.name)
	end
end