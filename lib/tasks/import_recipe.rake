# frozen_string_literal: true

# This rake job is to import recipe json
require 'json'
task import_recipe: :environment do
  File.open('public/recipes.json', 'r') do |f|
    f.each_line do |line|
      line_hash = JSON.parse(line)
      recipe = Recipe.create(
        name: line_hash['name'],
        difficulty: get_difficulty_level(line_hash['difficulty']),
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
        budget: get_budget_level(line_hash['budget']),
        author_tips: line_hash['author_tips'],
        nb_comments: line_hash['nb_comments']
      )

      line_hash['ingredients'].each do |ingredient|
        ingredient_record = Ingredient.find_or_create_by(ingredient_name: ingredient)
        RecipeIngredient.create(recipe: recipe, ingredient: ingredient_record)
      end

      line_hash['tags'].each do |tag|
        tag_record = Tag.find_or_create_by(tag_name: tag)
        RecipeTag.create(recipe: recipe, tag: tag_record) unless tag_record.nil?
      end
    end
  end
end

def get_difficulty_level(ingredient_level)
  case ingredient_level
  when 'très facile'
    0
  when 'Niveau moyen'
    1
  when 'facile'
    2
  when 'difficile'
    3
  end
end

def get_budget_level(budget_value)
  case budget_value
  when 'bon marché'
    0
  when 'Coût moyen'
    1
  when 'assez cher'
    2
  end
end
