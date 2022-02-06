# frozen_string_literal: true

# Creating tables Recipe and its association tables
class CreateCookBookTables < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :difficulty
      t.string :author
      t.string :image
      t.timestamps
    end

    create_table :recipe_time_details do |t|
      t.references :recipe
      t.string :cooking_time
      t.string :prep_time
      t.string :total_time
      t.timestamps
    end

    # My idea here is to have 2 columns while getting the input from user.
    # One to get the name of ingredient and next one is to get the quantity.
    # for example: if user tries to add salt as one of the ingredient,
    # Salt is very common so we will have one record in ingredients table and
    # corresponding quantity we can add in recipe_ingredients table
    create_table :ingredients do |t|
      t.text :ingredient_name
      t.timestamps
    end

    create_table :recipe_ingredients do |t|
      t.references :recipe
      t.references :ingredient
      t.string :quantity
      t.timestamps
    end

    create_table :tags do |t|
      t.string :tag_name
      t.timestamps
    end

    create_table :recipe_tags do |t|
      t.references :recipe, index: true
      t.references :tag
      t.timestamps
    end

    create_table :recipe_informations do |t|
      t.references :recipe
      t.string :rate
      t.integer :people_quantity
      t.integer :budget
      t.string :author_tips
      t.string :nb_comments
      t.timestamps
    end
  end
end
