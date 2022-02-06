# frozen_string_literal: true

class RecipesController < ApplicationController
  # has_arel_table_for RecipeIngredient

  before_action :set_recipe, except: :index

  def index
    @recipes = Recipe
								.search_functionality(params[:search_value])
								.page(params[:page])
								.per(params[:per_page]) if params[:search_value]
  end

  def show; end

  def set_recipe
    @recipe = Recipe.preload(:recipe_time_detail, :recipe_information, :ingredients).find(params[:id])
    return unless @recipe

    @recipe_time_detail = @recipe.recipe_time_detail
    @ingredients = @recipe.ingredients
    @recipe_information = @recipe.recipe_information
  end
end
