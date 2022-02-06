# frozen_string_literal: true

require 'rails_helper'

describe RecipesController, type: :controller do
  let!(:recipe_1) { create(:recipe, name: 'stuffed tomatoes') }
  let!(:recipe_2) { create(:recipe, name: 'Veggie Burger') }
  let!(:recipe_information_1) { create(:recipe_information, recipe: recipe_1) }
  let!(:recipe_information_2) { create(:recipe_information, recipe: recipe_2) }
  let!(:recipe_ingredient_1) { create(:recipe_ingredient, recipe: recipe_1) }
  let!(:recipe_ingredient_2) { create(:recipe_ingredient, ingredient: ingredient, recipe: recipe_2) }
  let!(:recipe_time_detail_1) { create(:recipe_time_detail, recipe: recipe_1) }
  let!(:recipe_time_detail_2) { create(:recipe_time_detail, recipe: recipe_2) }
  let!(:ingredient) { create(:ingredient, ingredient_name: 'tomato') }

  describe 'GET#show' do
    subject { get :index, params: { search_value: keywords } }

    before { subject }

    context 'when searched with valid text' do
      let(:keywords) { 'veggie' }

      it 'should return recipes contain search text in its name' do
        expect(assigns[:recipes]).to eq [recipe_2]
      end
    end

    context 'when search text matches both recipe name and ingredient name' do
      let(:keywords) { 'tomato' }

      it 'should return recipes with matching name and ingredient name' do
        expect(assigns[:recipes]).to eq [recipe_1, recipe_2]
      end
    end

    context 'when search with invalid text' do
      let(:keywords) { 'random text' }

      it 'recipes should be empty' do
        expect(assigns[:recipes]).to eq []
      end
    end
  end

  describe 'get#show' do
    subject { get :show, params: { id: recipe_id } }

    context 'with valid recipe id' do
      let(:recipe_id) { recipe_2.id }

      it 'returns recipe and its associated records' do
        subject
        expect(assigns[:recipe]).to eq(recipe_2)
        expect(assigns[:recipe_information]).to eq recipe_information_2
        expect(assigns[:ingredients]).to eq([ingredient])
      end
    end

    context 'with invalid recipe id' do
      let(:recipe_id) { '00' }
      it 'should render error page' do
        expect(subject).to render_template('errors/record_not_found')
      end
    end
  end
end
