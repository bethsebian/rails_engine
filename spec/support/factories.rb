FactoryGirl.define do

# CUSTOMERS
	factory :customer do
		sequence(:first_name) { |n| "C_First_#{n}" }
		sequence(:last_name) 	{ |n| "C_Last_#{n}" }
	end


# INVOICE_ITEMS
	factory :invoice_item do
		item_id
		invoice_id
		sequence(:quantity) 	{ |n| n }
		sequence(:unit_price) { |n| n * (1.01)}
	end


# INVOICES
	factory :invoice do
		sequence(:customer_id) { |n| n }
		sequence(:merchant_id) { |n| n }
		status "shipped"
	end


# ITEMS
	factory :item do
		sequence(:name) { |n| "First_#{n} Last_#{n}" }
		sequence(:description) { |n| "Lorem_#{n} ipsum_#{n} dolor_#{n} sit_#{n}..." }
		unit_price
		merchant_id
	end


# MERCHANTS
	factory :merchant do
		sequence(:name) { |n| "M_First_#{n} M_Last_#{n}" }
	end


# TRANSACTIONS
	factory :transaction do
		invoice_id
		sequence(:credit_card_number) { |n| (n + 1234567890123455) }
		result ["success", "failed"].sample
	end
end


#
#
# # // Create Categories, Categories with Items
#
#   category_titles = ["Carbon Offsets",
#                      "Wind Farm Certificates",
#                      "Clean Water Initiatives",
#                      "Waste Heat Recovery",
#                      "Forest Management Trust"]
#
#   sequence :category_title, category_titles.cycle do |n|
#     "#{n}"
#   end
#
#   sequence :slug do |n|
#     "#{n}-slug"
#   end
#
#   factory :category do
#     title { generate(:category_title) }
#     slug
#     image_url "https://static.pexels.com/photos/2759/clouds-cloudy-forest-trees.jpg"
#
#     factory :category_with_items do
#       transient do
#         items_count 5
#       end
#
#       after(:create) do |category, evaluator|
#         create_list(:item, evaluator.items_count, category: category)
#       end
#     end
#   end

