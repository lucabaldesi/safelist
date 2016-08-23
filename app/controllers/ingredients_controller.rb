class IngredientsController < ApplicationController
	def index
		@ingreds = Ingredient.all
	end

	def create
		@ing = Ingredient.new 
		@ing.name = params[:ingredient][:name]
		@ing.confirmed = params[:ingredient][:confirmed]

		if @ing.save()
			@msg = {info: ["Insertion complete"]}
		else
			@msg = {error: ["Already existing"]}
		end

		@ingreds = Ingredient.all
		render "index"
	end
end
