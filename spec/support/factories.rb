FactoryGirl.define do
	factory :customer do
		sequence(:first_name) { |n| "C_First_#{n}" }
		sequence(:last_name) 	{ |n| "C_Last_#{n}" }
	end

	factory :invoice_item do
		sequence(:item_id) 		{ |n| n }
		sequence(:invoice_id) { |n| n + 1 }
		sequence(:quantity) 	{ |n| n }
		sequence(:unit_price) { |n| n * (1.01)}
	end

	factory :invoice do
		sequence(:customer_id) { |n| n }
		sequence(:merchant_id) { |n| n }
		status "shipped"
	end

	factory :item do
		sequence(:name) { |n| "First_#{n} Last_#{n}" }
		sequence(:description) { |n| "Lorem_#{n} ipsum_#{n} dolor_#{n} sit_#{n}..." }
		unit_price
		merchant_id
	end

	factory :merchant do
		sequence(:name) { |n| "M_First_#{n} M_Last_#{n}" }
	end

	factory :transaction do
		sequence(:invoice_id) { |n| n + 1 }
		sequence(:credit_card_number) { |n| (n + 1234567890123455) }
		result ["success", "failed"].sample
	end
end