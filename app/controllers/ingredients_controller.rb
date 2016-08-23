class IngredientsController < ApplicationController
	def index
		@ingreds = Ingredient.order('name ASC').all
	end

	def create
		@ing = Ingredient.new 
		@ing.name = params[:ingredient][:name].downcase
		@ing.confirmed = params[:ingredient][:confirmed]

		if @ing.save()
			@msg = {info: ["Insertion complete"]}
		else
			@msg = {error: ["Already existing"]}
		end

		@ingreds = Ingredient.order('name ASC').all
		render "index"
	end
end
