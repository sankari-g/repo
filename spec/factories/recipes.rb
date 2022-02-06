FactoryBot.define do
	factory :recipe, class: Recipe do
		name { Faker::Food.dish }
		difficulty { 0 }
		author { Faker::Name.name }
	end
end