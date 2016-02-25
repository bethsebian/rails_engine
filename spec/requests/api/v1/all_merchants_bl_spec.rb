# require 'rails_helper'
#
# RSpec.describe "All Merchants Business Intelligence API" do
#
# 	it 'returns the top merchants ranked by total revenue' do
# 		m_1, m_2, m_3, m_4 = create_list(:merchant, 4)
# 		i_1 = create(:invoice, merchant_id: m_1.id)
# 		ii_1 = create(:invoice_item, invoice_id: i_1.id, unit_price: 9, quantity: 1)
# 		i_2 = create(:invoice, merchant_id: m_2.id)
# 		ii_2 = create(:invoice_item, invoice_id: i_2.id, unit_price: 6, quantity: 1)
# 		i_3 = create(:invoice, merchant_id: m_3.id)
# 		ii_3 = create(:invoice_item, invoice_id: i_3.id, unit_price: 8, quantity: 1)
# 		i_4 = create(:invoice, merchant_id: m_4.id)
# 		ii_4 = create(:invoice_item, invoice_id: i_4.id, unit_price: 7, quantity: 1)
#
# 		get "/api/v1/merchants/most_revenue?quantity=2"
#
# 		expect(response).to be_success
# 		expect(json.length).to eq(2)
# 		expect(json).to include(m_1, m_3)
# 	end
# end

# GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
# GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
# GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants

#
# create_table "invoice_items", force: :cascade do |t|
# 	t.integer  "item_id"
# 	t.integer  "invoice_id"
# 	t.integer  "quantity"
# 	t.integer  "unit_price"
# 	t.datetime "created_at", null: false
# 	t.datetime "updated_at", null: false
# end
#
# create_table "invoices", force: :cascade do |t|
# 	t.integer  "customer_id"
# 	t.integer  "merchant_id"
# 	t.citext   "status"
# 	t.datetime "created_at",  null: false
# 	t.datetime "updated_at",  null: false