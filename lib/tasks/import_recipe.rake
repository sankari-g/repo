# frozen_string_literal: true

# This rake job is to import recipe json
require 'json'
task import_recipe: :environment do
  difficulty_level = { 'très facile' => 0, 'Niveau moyen' => 1, 'facile' => 2, 'difficile' => 3 }
  budget_level = { 'bon marché' => 0, 'Coût moyen' => 1, 'assez cher' => 2 }

  datas = []
  File.open('public/recipes.json', 'r') do |f|
    f.each_line do |line|
      datas << JSON.parse(line)
    rescue JSON::ParserError
      puts 'data parse failed'
    end

    Parallel.each(datas, in_threads: 4) do |data|
      recipe = Recipe.create(
        name: data['name'],
        difficulty: difficulty_level[data['difficulty']],
        author: data['author'],
        image: data['image']
      )

      RecipeTimeDetail.create(
        recipe: recipe,
        cooking_time: data['cook_time'],
        prep_time: data['prep_time'],
        total_time: data['total_time']
      )

      RecipeInformation.create(
        recipe: recipe,
        rate: data['rate'],
        people_quantity: data['people_quantity'],
        budget: budget_level[data['budget']],
        author_tips: data['author_tips'],
        nb_comments: data['nb_comments']
      )

      data['ingredients'].each do |ingredient|
        ingredient_record = Ingredient.find_or_create_by(ingredient_name: ingredient)
        RecipeIngredient.create(recipe: recipe, ingredient: ingredient_record)
      end

      data['tags'].each do |tag|
        tag_record = Tag.find_or_create_by(tag_name: tag)
        RecipeTag.create(recipe: recipe, tag: tag_record)
      end
      puts "recipe #{recipe&.id} imported"
    end
  end
end
