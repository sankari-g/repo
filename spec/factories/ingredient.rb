FactoryBot.define do
	factory :ingredient, class: Ingredient do
		ingredient_name { Faker::Food.ingredient }
	end
end