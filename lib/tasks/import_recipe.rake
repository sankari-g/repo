# frozen_string_literal: true

# This rake job is to import recipe json
require 'json'
task import_recipe: :environment do
  difficulty_level = { 'très facile' => 0, 'Niveau moyen' => 1, 'facile' => 2, 'difficile' => 3 }
  budget_level = { 'bon marché' => 0, 'Coût moyen' => 1, 'assez cher' => 2 }

  File.open('public/recipes.json', 'r') do |f|
    f.each_line do |line|
      line_hash = JSON.parse(line)
      recipe = Recipe.create(
        name: line_hash['name'],
        difficulty: difficulty_level[line_hash['difficulty']],
        author: line_hash['author'],
        image: line_hash['image']
      )

      RecipeTimeDetail.create(
        recipe: recipe,
        cooking_time: line_hash['cook_time'],
        prep_time: line_hash['prep_time'],
        total_time: line_hash['total_time']
      )

      RecipeInformation.create(
        recipe: recipe,
        rate: line_hash['rate'],
        people_quantity: line_hash['people_quantity'],
        budget: budget_level[line_hash['budget']],
        author_tips: line_hash['author_tips'],
        nb_comments: line_hash['nb_comments']
      )

      line_hash['ingredients'].each do |ingredient|
        ingredient_record = Ingredient.find_or_create_by(ingredient_name: ingredient)
        RecipeIngredient.create(recipe: recipe, ingredient: ingredient_record)
      end

      line_hash['tags'].each do |tag|
        tag_record = Tag.find_or_create_by(tag_name: tag)
        RecipeTag.create(recipe: recipe, tag: tag_record)
      end
    end
  end
end
