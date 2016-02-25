require 'rails_helper'

RSpec.describe "Transaction API" do
  attr_reader :t_1, :t_2, :t_3

  before(:each) do
		@t_1, @t_2, @t_3 = create_list(:transaction, 3)
  end

  it 'sends a list of transactions' do
    get '/api/v1/transactions.json'

    expect(response).to be_success
    expect(json.length).to eq(3)
    expect(json.last['invoice_id']).to eq(t_1.invoice_id)
    expect(json.last['credit_card_number']).to eq(t_1.credit_card_number.to_s)
    expect(json.last['result']).to eq(t_1.result)
  end

	it 'sends details on one transaction when passed ID' do
		get "/api/v1/transactions/#{t_2.id}.json"

		expect(response).to be_success
		expect(json["id"]).to eq(t_2.id)
    expect(json['invoice_id']).to eq(t_2.invoice_id)
    expect(json['credit_card_number']).to eq(t_2.credit_card_number.to_s)
    expect(json['result']).to eq(t_2.result)
	end

  it 'sends details on transaction when passed ID as param' do
		get "/api/v1/transactions/find?id=#{t_2.id}"

    expect(response).to be_success
    expect(json["id"]).to eq(t_2.id)
    expect(json['invoice_id']).to eq(t_2.invoice_id)
    expect(json['credit_card_number']).to eq(t_2.credit_card_number.to_s)
    expect(json['result']).to eq(t_2.result)
	end

	it 'sends details on transaction when passed INVOICE_ID as param' do
    get "/api/v1/transactions/find?invoice_id=#{t_2.invoice_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(t_2.id)
    expect(json['invoice_id']).to eq(t_2.invoice_id)
    expect(json['credit_card_number']).to eq(t_2.credit_card_number.to_s)
		expect(json['result']).to eq(t_2.result)
  end

  it 'sends details on first matching transaction when passed INVOICE_ID as param' do
    t_4 = create(:transaction, invoice_id: t_2.invoice_id)
    get "/api/v1/transactions/find?invoice_id=#{t_2.invoice_id}"

    expect(response).to be_success
    expect(json["id"]).to eq(t_4.id)
    expect(json["id"]).to_not eq(t_2.id)
    expect(json['invoice_id']).to eq(t_4.invoice_id)
		expect(json['credit_card_number']).to eq(t_4.credit_card_number.to_s)
		expect(json['result']).to eq(t_4.result)
  end

	it 'sends details on all matching transactions when passed INVOICE_ID as param' do
		t_4 = create(:transaction, invoice_id: 12)
		t_5 = create(:transaction, invoice_id: t_4.invoice_id)
		get "/api/v1/transactions/find_all?invoice_id=#{t_4.invoice_id}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(t_4.id)
	end

	it 'sends details on transaction when passed CREDIT_CARD_NUMBER as param' do
    get "/api/v1/transactions/find?credit_card_number=#{t_2.credit_card_number}"

    expect(response).to be_success
    expect(json["id"]).to eq(t_2.id)
    expect(json['invoice_id']).to eq(t_2.invoice_id)
    expect(json['credit_card_number']).to eq(t_2.credit_card_number.to_s)
		expect(json['result']).to eq(t_2.result)
  end

  it 'sends details on first matching transaction when passed CREDIT_CARD_NUMBER as param' do
    t_4 = create(:transaction, credit_card_number: t_2.credit_card_number)
    get "/api/v1/transactions/find?credit_card_number=#{t_2.credit_card_number}"

    expect(response).to be_success
    expect(json["id"]).to eq(t_4.id)
    expect(json["id"]).to_not eq(t_2.id)
    expect(json['invoice_id']).to eq(t_4.invoice_id)
		expect(json['credit_card_number']).to eq(t_4.credit_card_number.to_s)
		expect(json['result']).to eq(t_4.result)
  end

	it 'sends details on all matching transactions when passed CREDIT_CARD_NUMBER as param' do
		t_4 = create(:transaction, credit_card_number: 8888888888888888)
		t_5 = create(:transaction, credit_card_number: t_4.credit_card_number)
		get "/api/v1/transactions/find_all?credit_card_number=#{t_4.credit_card_number}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(t_4.id)
	end

	it 'sends details on transaction when passed RESULT as param' do
		t_4 = create(:transaction, result: "test")
		get "/api/v1/transactions/find?result=#{t_4.result}"

    expect(response).to be_success
    expect(json["id"]).to eq(t_4.id)
    expect(json['invoice_id']).to eq(t_4.invoice_id)
    expect(json['credit_card_number']).to eq(t_4.credit_card_number.to_s)
		expect(json['result']).to eq(t_4.result)
  end

  it 'sends details on first matching transaction when passed RESULT as param' do
    t_4 = create(:transaction, result: "test")
		t_5 = create(:transaction, result: t_4.result)
    get "/api/v1/transactions/find?result=#{t_4.result}"

    expect(response).to be_success
    expect(json["id"]).to eq(t_5.id)
    expect(json["id"]).to_not eq(t_4.id)
    expect(json['invoice_id']).to eq(t_5.invoice_id)
		expect(json['credit_card_number']).to eq(t_5.credit_card_number.to_s)
		expect(json['result']).to eq(t_5.result)
  end

	it 'sends details on transaction when passed RESULT as param (case-insensitive)' do
		t_4 = create(:transaction, result: "test")
		get "/api/v1/transactions/find?result=#{t_4.result.upcase}"

		expect(response).to be_success
		expect(json["id"]).to eq(t_4.id)
		expect(json['invoice_id']).to eq(t_4.invoice_id)
		expect(json['credit_card_number']).to eq(t_4.credit_card_number.to_s)
		expect(json['result']).to eq(t_4.result)
	end

	it 'sends details on all matching transactions when passed RESULT as param' do
		t_4 = create(:transaction, result: "test")
		t_5 = create(:transaction, result: t_4.result)
		get "/api/v1/transactions/find_all?result=#{t_4.result}"

		expect(response).to be_success
		expect(json.length).to eq(2)
		expect(json.last['id']).to eq(t_4.id)
	end

  it 'sends details on transactions when passed RESULT with spaces as param' do
    t_4 = create(:transaction, result: "pretty bad")
    get "/api/v1/transactions/find?result=pretty-bad"

    expect(response).to be_success
    expect(json["id"]).to eq(t_4.id)
  end

	it 'sends details on random transaction when passed RANDOM' do
		get "/api/v1/transactions/random.json"

		t_random = Transaction.find(json['id'])

		expect(response).to be_success
		expect(json['invoice_id']).to eq(t_random.invoice_id)
		expect(json['credit_card_number']).to eq(t_random.credit_card_number.to_s)
		expect(json['result']).to eq(t_random.result)
	end
end