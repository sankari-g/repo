FactoryBot.define do
	factory :recipe_information, class: RecipeInformation do
		association :recipe, factory: :recipe
		rate { Faker::Number.within(range: 1..5) }
		people_quantity { Faker::Number.number(digits: 2) }
		budget { 2 }
	end
end