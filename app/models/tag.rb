# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
end
