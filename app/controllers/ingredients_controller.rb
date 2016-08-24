class IngredientsController < ApplicationController
	def page
		@ingreds = Ingredient.order('name ASC').all
		@staged = @ingreds.select {|i| i.confirmed == false}
		@safe = @ingreds.select {|i| i.confirmed == true && i.safe == true}
		@unsafe = @ingreds.select {|i| i.confirmed == true && i.safe == false}
		render "index"
	end

	def show
		page
	end

	def index
		page
	end

	def create
		@ing = Ingredient.new 
		@ing.name = params[:ingredient][:name].downcase
		@ing.confirmed = false
		@ing.safe = false

		if @ing.save()
			@msg = {info: ["Insertion complete"]}
		else
			@msg = {error: ["Already existing"]}
		end

		page
	end

	def destroy
		id = params[:id]
		ing = Ingredient.find_by_id(id)
		if ing
			Ingredient.delete(id)
			@msg = {info: ["Deletion complete"]}
		else
			@msg = {error: ["Ingredient not found"]}
		end
		page
	end

	def update
		id = params[:id]
		conf = params[:confirmed]
		safe = params[:safe]
		ing = Ingredient.find_by_id(id)
		if ing
			if conf == "false"
				ing.confirmed = false
			end
			if conf == "true"
				ing.confirmed = true
			end
			if safe == "false"
				ing.safe = false
				ing.confirmed = true
			end
			if safe == "true"
				ing.safe = true
				ing.confirmed = true
			end
			ing.save()
			@msg = {info: ["Successful update"]}
		else
			@msg = {error: ["Ingredient not found"]}
		end
		page
	end
end
