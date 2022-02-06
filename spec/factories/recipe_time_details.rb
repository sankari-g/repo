FactoryBot.define do
	factory :recipe_time_detail, class: RecipeTimeDetail do
		association :recipe, factory: :recipe
		cook_time_random = Faker::Number.within(range: 1..30)
		prep_time_random = Faker::Number.within(range: 1..30)
		cooking_time { cook_time_random.to_s+' min' }
		prep_time { prep_time_random.to_s+' min' }

	end
end