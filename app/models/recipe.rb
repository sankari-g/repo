# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_one :recipe_time_detail, dependent: :destroy
  has_one :recipe_information, dependent: :destroy

  enum difficulty: {
    'très facile': 0,
    'Niveau moyen': 1,
    'facile': 2,
    'difficile': 3
  }

  def self.search_functionality(keywords)
    keywords = keywords.split
    ingredients = Ingredient.arel_table
    Recipe
      .where(keywords.map do |keyword|
               arel_table[:name].matches("%#{keyword}%").or(ingredients[:ingredient_name].matches("%#{keyword}%"))
							end.reduce(&:or))
      .preload(:recipe_time_detail)
      .joins(:ingredients)
      .distinct
  end
end
