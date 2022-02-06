FactoryBot.define do
	factory :recipe_ingredient, class: RecipeIngredient do
		association :recipe, factory: :recipe
		association :ingredient, factory: :ingredient
	end
end