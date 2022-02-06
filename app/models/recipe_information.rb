# frozen_string_literal: true

class RecipeInformation < ApplicationRecord
  belongs_to :recipe

  enum budget: {
    Cheap: 0,
    'Average Cost': 1,
    'Quite Expensive': 2
  }
end
